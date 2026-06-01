import { useEffect, useState, useRef } from "react";
import { Link, useLocation } from "react-router-dom";
import { useParams } from "react-router-dom";
import { formatDateDMY } from "../../utils/dateUtils";
import { getProfile, assignPlan, confirmPayment, getPlanHistory, setProfilePicture as setProfilePictureApi } from "../../logic/profiles.logic";
import { getAttachments, uploadAttachments, deleteAttachments } from "../../logic/attachments.logic";
import FamilyList from "../../components/family/FamilyList";
import FamilyForm from "../../components/family/FamilyForm";
import AddressSection from "../../components/address/AddressSection";
import OccupationSection from "../../components/occupation/OccupationSection";
import { getAddresses } from "../../logic/address.logic";
import { getEducation } from "../../logic/education.logic";
import { getOccupation } from "../../logic/occupation.logic";
import { toJpeg } from "html-to-image";
import jsPDF from "jspdf";
import { BASE_URL, COMPANY } from "../../api/apiClient";
import { getFamily, addFamily, updateFamily, deleteFamily } from "../../logic/family.logic";
import { loadFormEnums } from "../../logic/enumStore";
import EducationSection from "../../components/education/EducationSection";
import { useAuth } from "../../auth/AuthContext";

const getImageUrl = (url) => {
  if (!url) return "/placeholder-profile.png";

  if (url.startsWith("http")) {
    return url;
  }

  return `${BASE_URL}${url}`;
};

// ─── Constants ────────────────────────────────────────────────────────────────
const PHOTO_SLOTS = [
  { key: "horoscope",        label: "Horoscope Photo",  required: false },
  { key: "traditional_wear", label: "Traditional Wear", required: false },
  { key: "casual_wear",      label: "Casual Wear",      required: false },
  { key: "activity_hobby",   label: "Activity / Hobby", required: false },
  { key: "family",           label: "Family Photo",     required: false },
];

const SLOT_BADGE = {
  horoscope:        "Horoscope",
  traditional_wear: "Traditional Wear",
  casual_wear:      "Casual Wear",
  activity_hobby:   "Activity / Hobby",
  family:           "Family Photo",
};

const CAN_SET_PROFILE_SLOTS = new Set(["traditional_wear", "casual_wear", "activity_hobby"]);
const canSetAsProfile = (category) => !category || CAN_SET_PROFILE_SLOTS.has(category);
const GRADIENT = "linear-gradient(110deg, var(--amber), var(--rose-light))";

const SUBSCRIPTION_PLANS = [
  { name: "bronze",  label: "Bronze",  duration: "6 months"  },
  { name: "silver",  label: "Silver",  duration: "12 months" },
  { name: "gold",    label: "Gold",    duration: "24 months" },
  { name: "diamond", label: "Diamond", duration: "36 months" },
];

const subLabel = { bronze: "Bronze", silver: "Silver", gold: "Gold", diamond: "Diamond" };
const colorMap = { paid: "badge-teal", expiring: "badge-amber", expired: "badge-neutral", unpaid: "badge-neutral" };

// ─── Helpers ──────────────────────────────────────────────────────────────────
const SectionLabel = ({ children }) => (
  <div style={{
    fontSize: "10.5px", fontWeight: 700, letterSpacing: ".12em",
    textTransform: "uppercase", color: "var(--amber)",
    display: "flex", alignItems: "center", gap: "8px", marginBottom: "8px"
  }}>
    {children}
    <span style={{ flex: 1, height: "1px", background: "var(--border)" }} />
  </div>
);

const Attr = ({ label, value }) => {
  if (!value && value !== 0) return null;
  return (
    <div style={{
      padding: "5px 12px", background: "var(--bg)",
      borderRadius: "var(--r-sm)", border: "1px solid var(--border)",
      fontSize: "12.5px", color: "var(--ink-2)",
      display: "flex", alignItems: "center", gap: "10px",
      position: "relative", overflow: "hidden",
      transition: "border-color 160ms ease, transform 160ms ease",
    }}
      onMouseEnter={e => { e.currentTarget.style.borderColor = "var(--amber)"; e.currentTarget.style.transform = "translateX(4px)"; }}
      onMouseLeave={e => { e.currentTarget.style.borderColor = "var(--border)"; e.currentTarget.style.transform = "translateX(0)"; }}
    >
      <span style={{ fontSize: "9.5px", fontWeight: 700, letterSpacing: ".08em", textTransform: "uppercase", color: "var(--amber)", minWidth: "90px", flexShrink: 0 }}>
        {label}
      </span>
      <span style={{ color: "var(--ink-2)" }}>{value}</span>
    </div>
  );
};

const formatSibling = (total, married, position) => {
  if (total === null || total === undefined || total === "") return null;
  const n = parseInt(total) || 0;
  const m = parseInt(married) || 0;
  if (n === 0) return `No ${position}`;
  const suffix = m > 0 ? (n === 1 ? " (Married)" : ` (${m} Married)`) : "";
  return `${n} ${position}${suffix}`;
};

const buildSiblingLines = (profile) => {
  const lines = [];
  const elder   = formatSibling(profile.broe,  profile.broem,  "Elder");
  const younger = formatSibling(profile.broy,  profile.borym,  "Younger");
  if (elder || younger) lines.push({ label: "Brothers", text: [elder, younger].filter(Boolean).join(" · ") });
  const elderSis   = formatSibling(profile.sise, profile.sisem, "Elder");
  const youngerSis = formatSibling(profile.sisy, profile.sisym, "Younger");
  if (elderSis || youngerSis) lines.push({ label: "Sisters", text: [elderSis, youngerSis].filter(Boolean).join(" · ") });
  return lines;
};

const formatTwin = (hastwin) => {
  if (hastwin === null || hastwin === undefined || hastwin === "") return null;
  const v = parseInt(hastwin);
  if (v === 1) return "Yes";
  if (v === 2) return "No";
  return null;
};

const formatHeight = (cm) => {
  if (!cm && cm !== 0) return null;
  const totalCm = parseFloat(cm);
  if (isNaN(totalCm)) return null;
  const totalInches = totalCm / 2.54;
  const feet = Math.floor(totalInches / 12);
  const inches = Math.round(totalInches % 12);
  return `${feet} ft ${inches} in (${Math.round(totalCm)} cm)`;
};

const calculateAge = (birthdate) => {
  if (!birthdate) return "";
  const today = new Date();
  const dob = new Date(birthdate);
  let age = today.getFullYear() - dob.getFullYear();
  const monthDiff = today.getMonth() - dob.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) age--;
  return age;
};

// ─── Export Layout — Details page ─────────────────────────────────────────────
function ExportLayoutDetails({ profile, enums, family, familyAddresses, profilePhotoUrl, profileAddress, education, occupation, parentOccupations }) {
  if (!profile || !enums) return null;

  const amber      = "#c97d10";
  const amberLight = "#fef3dc";
  const border     = "#e5d9c0";
  const ink        = "#1a1208";
  const ink2       = "#3d3020";
  const ink3       = "#7a6a52";
  const surface    = "#fffdf9";
  const bg         = "#faf7f2";

  const siblings = buildSiblingLines(profile);
  const age = calculateAge(profile.birthdate);

  const maritalStatusName = enums?.maritalsts?.map?.[String(profile?.maritalsts)]?.toLowerCase();
  const showChildren = (maritalStatusName === "divorced" || maritalStatusName === "widow") &&
    profile?.childrencount != null && profile?.childrencount !== "";

  const ExRow = ({ label, value }) => {
    if (!value && value !== 0) return null;
    return (
      <div style={{ display: "flex", gap: "0", marginBottom: "3px" }}>
        <span style={{
          minWidth: "148px", flexShrink: 0,
          fontSize: "10px", fontWeight: 700,
          color: amber, textTransform: "uppercase", letterSpacing: ".05em",
          paddingTop: "3px",
        }}>
          {label}
        </span>
        <span style={{
          flex: 1, fontSize: "12px", color: ink2,
          background: bg, borderRadius: "4px",
          padding: "2px 8px", border: `1px solid ${border}`,
        }}>
          {value}
        </span>
      </div>
    );
  };

  const ExSection = ({ title, children }) => (
    <div style={{ marginBottom: "18px" }}>
      <div style={{
        fontSize: "9.5px", fontWeight: 700, letterSpacing: ".14em",
        textTransform: "uppercase", color: amber,
        display: "flex", alignItems: "center", gap: "8px",
        marginBottom: "8px",
      }}>
        {title}
        <span style={{ flex: 1, height: "1px", background: border }} />
      </div>
      <div style={{ display: "flex", flexDirection: "column", gap: "3px" }}>
        {children}
      </div>
    </div>
  );

  return (
    <div style={{
      fontFamily: "system-ui, -apple-system, Arial, sans-serif",
      background: surface,
      color: ink,
      width: "760px",
      padding: "0",
    }}>
      {/* Header */}
      <div style={{
        background: "linear-gradient(110deg, #b8670a, #c97d10, #d4902a)",
        padding: "22px 36px 18px",
        color: "#fff",
      }}>
        <div style={{ fontSize: "18px", fontWeight: 700, letterSpacing: ".02em", marginBottom: "2px" }}>
          {COMPANY.name}
        </div>
        <div style={{ fontSize: "12px", fontWeight: 400, opacity: 0.88, marginBottom: "6px" }}>
          {COMPANY.subtitle}
        </div>
        <div style={{ fontSize: "10px", opacity: 0.75 }}>
          {COMPANY.address} {COMPANY.address2}
        </div>
      </div>

      {/* Profile hero */}
      <div style={{ display: "flex", gap: "0", borderBottom: `2px solid ${border}`, background: "#fff" }}>
        <div style={{
          width: "160px", flexShrink: 0, background: amberLight,
          display: "flex", alignItems: "center", justifyContent: "center",
          minHeight: "200px", overflow: "hidden",
        }}>
          {profilePhotoUrl ? (
            <img src={profilePhotoUrl} alt="Profile" crossOrigin="anonymous"
              style={{ width: "160px", height: "200px", objectFit: "cover", display: "block" }}
            />
          ) : (
            <div style={{
              width: "80px", height: "80px", borderRadius: "50%", background: border,
              display: "flex", alignItems: "center", justifyContent: "center",
              fontSize: "28px", fontWeight: 700, color: amber,
            }}>
              {(profile.firstname || "?")[0]}
            </div>
          )}
        </div>

        <div style={{ flex: 1, padding: "22px 28px" }}>
          <div style={{ fontSize: "26px", fontWeight: 300, fontStyle: "italic", color: ink, lineHeight: 1.15, marginBottom: "4px" }}>
            {profile.firstname} {profile.middlei} {profile.lastname}
          </div>
          <div style={{ fontSize: "11px", color: ink3, marginBottom: "14px" }}>
            {profile.client_id ?? `#${profile.id}`}{profile.familynames ? ` · ${profile.familynames}` : ""}
          </div>
          <div style={{ display: "flex", gap: "20px", flexWrap: "wrap" }}>
            {[
              { l: "Age",     v: age ? `${age} years` : null },
              { l: "Gender",  v: profile.gender === 1 ? "Male" : "Female" },
              { l: "Height",  v: formatHeight(profile.height) },
              { l: "Weight",  v: profile.weight ? `${profile.weight} kg` : null },
              { l: "Marital", v: enums?.maritalsts?.map?.[String(profile.maritalsts)] },
            ].filter(x => x.v).map(({ l, v }) => (
              <div key={l}>
                <div style={{ fontSize: "9px", fontWeight: 700, textTransform: "uppercase", color: amber, letterSpacing: ".08em" }}>{l}</div>
                <div style={{ fontSize: "13px", color: ink2, marginTop: "2px" }}>{v}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Body — two-column */}
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "0", padding: "20px 28px", background: surface }}>

        {/* LEFT */}
        <div style={{ paddingRight: "20px", borderRight: `1px solid ${border}` }}>
          <ExSection title="Personal Details">
            <ExRow label="Birthdate"   value={formatDateDMY(profile.birthdate)} />
            <ExRow label="Birth Time"  value={profile.birthtime} />
            <ExRow label="Birth Place" value={profile.birthplace} />
            <ExRow label="Color"       value={enums?.color?.map?.[profile.color]} />
            <ExRow label="Phone"       value={profile.phonenumber} />
            <ExRow label="Email"       value={profile.email} />
            {showChildren && <ExRow label="Children" value={profile.childrencount} />}
          </ExSection>

          <ExSection title="Horoscope">
            <ExRow label="Birth Star"  value={enums?.birthstar?.map?.[profile.birthstar]} />
            <ExRow label="Pada"        value={enums?.birthpada?.map?.[profile.starpada]} />
            <ExRow label="Birth Rashi" value={enums?.birthrasi?.map?.[profile.birthrasi]} />
            <ExRow label="Swagothra"   value={profile?.swagothranm?.gothraname} />
            <ExRow label="Mama Gothra" value={profile?.mamagothranm?.gothraname} />
          </ExSection>

          <ExSection title="Asset & Income">
            <ExRow label="Asset Details"           value={profile.assetdets} />
            <ExRow label="Asset Value (Cr)"        value={profile.networth} />
            <ExRow label="Annual Income (L)"       value={profile.income} />
          </ExSection>
        </div>

        {/* RIGHT */}
        <div style={{ paddingLeft: "20px" }}>

          <ExSection title="Family Details">
            {siblings.map(({ label, text }) => (
              <ExRow key={label} label={label} value={text} />
            ))}
            <ExRow label="Has Twin?" value={formatTwin(profile.hastwin)} />
          </ExSection>

          {(() => {
            const father = family?.find(m => Number(m.relationtype) === 1);
            const mother = family?.find(m => Number(m.relationtype) === 2);
            if (!father && !mother) return null;
            const memberBlock = (m) => {
              const name = [m.firstname, m.lastname].filter(Boolean).join(" ");
              const occ  = familyAddresses?.[m.id];
              const addr = occ?.current
                ? [occ.current.city, occ.current.state].filter(Boolean).join(", ")
                : null;
              const status = Number(m.livingstatus) === 2 ? "Deceased" : "Alive";
              return (
                <div key={m.id} style={{
                  marginBottom: "6px", padding: "7px 10px",
                  background: bg, borderRadius: "4px", border: `1px solid ${border}`,
                }}>
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                    <div style={{ fontSize: "12px", fontWeight: 700, color: ink2 }}>{name}</div>
                    <div style={{ fontSize: "9px", color: Number(m.livingstatus) === 2 ? "#999" : "#2a7a4f", fontWeight: 600, textTransform: "uppercase", letterSpacing: ".05em" }}>{status}</div>
                  </div>
                  {(() => {
                    const occs = parentOccupations?.[m.id];
                    if (!occs || !occs.length) return null;
                    const o = occs[0];
                    const occStr = [o.occname, o.compname].filter(Boolean).join(", ");
                    return occStr ? <div style={{ fontSize: "10px", color: ink3, marginTop: "2px" }}>{occStr}</div> : null;
                  })()}
                  {addr && <div style={{ fontSize: "10px", color: ink3 }}>{addr}</div>}
                </div>
              );
            };
            return (
              <ExSection title="Parents">
                {father && memberBlock(father)}
                {mother && memberBlock(mother)}
              </ExSection>
            );
          })()}

          {education && education.length > 0 && (
            <ExSection title="Education">
              {education.map((edu, i) => (
                <div key={i} style={{
                  marginBottom: "4px", padding: "6px 10px",
                  background: bg, borderRadius: "4px", border: `1px solid ${border}`,
                }}>
                  <div style={{ fontSize: "12px", fontWeight: 700, color: ink2 }}>{edu.degree}{edu.fieldstudy ? ` — ${edu.fieldstudy}` : ""}</div>
                  {edu.college && <div style={{ fontSize: "10px", color: ink3 }}>{edu.college}{edu.year ? `, ${edu.year}` : ""}</div>}
                </div>
              ))}
            </ExSection>
          )}

          {occupation && occupation.length > 0 && (
            <ExSection title="Occupation">
              {occupation.map((occ, i) => (
                <div key={i} style={{
                  marginBottom: "4px", padding: "6px 10px",
                  background: bg, borderRadius: "4px", border: `1px solid ${border}`,
                }}>
                  <div style={{ fontSize: "12px", fontWeight: 700, color: ink2 }}>{occ.occname}{occ.occrole ? ` — ${occ.occrole}` : ""}</div>
                  {occ.compname && <div style={{ fontSize: "10px", color: ink3 }}>{occ.compname}</div>}
                  {occ.income && <div style={{ fontSize: "10px", color: ink3 }}>Income: {occ.income}L/yr</div>}
                </div>
              ))}
            </ExSection>
          )}

          {profileAddress?.current && (
            <ExSection title="Address">
              <ExRow label="City"    value={profileAddress.current.city} />
              <ExRow label="State"   value={profileAddress.current.state} />
              <ExRow label="Country" value={profileAddress.current.country} />
            </ExSection>
          )}

        </div>
      </div>

      {/* Footer */}
      <div style={{
        borderTop: `2px solid ${border}`,
        padding: "10px 28px",
        display: "flex", justifyContent: "space-between", alignItems: "center",
        background: amberLight,
      }}>
        <div style={{ fontSize: "13px", fontWeight: 600, color: ink2 }}>
          Contact for more details — Venkatesh Babu (S/O Arjunaiah)
        </div>
        <div style={{ fontSize: "13px", fontWeight: 600, color: ink2 }}>
          Mob: 9844085118
        </div>
      </div>
    </div>
  );
}

// ─── Export Layout — Photos page ──────────────────────────────────────────────
function ExportLayoutPhotos({ profile, profilePhotoUrl, allImages = [] }) {
  if (!allImages.length) return null;

  const amber      = "#c97d10";
  const amberLight = "#fef3dc";
  const border     = "#e5d9c0";
  const ink2       = "#3d3020";
  const ink3       = "#7a6a52";
  const surface    = "#fffdf9";

  return (
    <div style={{
      fontFamily: "system-ui, -apple-system, Arial, sans-serif",
      background: surface,
      width: "760px",
      padding: "0",
    }}>
      <div style={{
        background: "linear-gradient(110deg, #b8670a, #c97d10, #d4902a)",
        padding: "22px 36px 18px",
        color: "#fff",
      }}>
        <div style={{ fontSize: "18px", fontWeight: 700, letterSpacing: ".02em", marginBottom: "2px" }}>
          {COMPANY.name}
        </div>
        <div style={{ fontSize: "12px", opacity: 0.88 }}>
          {COMPANY.subtitle} · Photos — {profile.firstname} {profile.lastname} #{profile.id}
        </div>
      </div>

      <div style={{ padding: "24px 28px" }}>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "16px" }}>
          {profilePhotoUrl && (
            <div>
              <img src={profilePhotoUrl} alt="Profile" crossOrigin="anonymous"
                style={{ width: "100%", aspectRatio: "3/4", objectFit: "cover", borderRadius: "6px", display: "block", border: `2px solid ${amber}` }}
              />
              <div style={{ fontSize: "11px", color: ink3, textAlign: "center", marginTop: "6px", fontWeight: 600 }}>
                Profile Photo
              </div>
            </div>
          )}
          {allImages
            .filter(img => img.id !== profile.profilePictureId)
            .map(img => (
              <div key={img.id}>
                <img src={getImageUrl(img.file_url)} alt={img.category || "photo"} crossOrigin="anonymous"
                  style={{ width: "100%", aspectRatio: "3/4", objectFit: "cover", borderRadius: "6px", display: "block", border: `1px solid ${border}` }}
                />
                {img.category && (
                  <div style={{ fontSize: "11px", color: ink3, textAlign: "center", marginTop: "6px", textTransform: "capitalize" }}>
                    {img.category.replace(/_/g, " ")}
                  </div>
                )}
              </div>
            ))
          }
        </div>
      </div>

      <div style={{
        borderTop: `2px solid ${border}`,
        padding: "12px 28px",
        display: "flex", justifyContent: "space-between", alignItems: "center",
        background: amberLight, marginTop: "8px",
      }}>
        <div style={{ fontSize: "13px", fontWeight: 600, color: ink2 }}>
          Contact for more details — Venkatesh Babu (S/O Arjunaiah)
        </div>
        <div style={{ fontSize: "13px", fontWeight: 600, color: ink2 }}>
          Mob: 9844085118
        </div>
      </div>
    </div>
  );
}

// ═════════════════════════════════════════════════════════════════════════════
export default function ProfileView() {
  const { id }       = useParams();
  const location     = useLocation();
  const { isAdmin }  = useAuth();
  const admin        = isAdmin();

  const [profile,        setProfile]        = useState(null);
  const [images,         setImages]         = useState([]);
  const [files,          setFiles]          = useState([]);
  const [uploading,      setUploading]      = useState(false);
  const [family,         setFamily]         = useState([]);
  const [editingFamily,  setEditingFamily]  = useState(null);
  const [showFamilyForm, setShowFamilyForm] = useState(false);
  const [enums,          setEnums]          = useState(null);
  const [familyAddresses,setFamilyAddresses]= useState({});
  const [isDragging,     setIsDragging]     = useState(false);
  const [previewIndex,   setPreviewIndex]   = useState(null);
  const [zoomed,         setZoomed]         = useState(false);
  const [dragPos,        setDragPos]        = useState({ x: 0, y: 0 });
  const [dragging,       setDragging]       = useState(false);
  const [latestPlan,     setLatestPlan]     = useState(null);
  const [planHistory,    setPlanHistory]    = useState([]);
  const [showHistory,    setShowHistory]    = useState(false);
  const [selectedPlan,   setSelectedPlan]   = useState("silver");
  const [planSaving,     setPlanSaving]     = useState(false);
  const [exporting,      setExporting]      = useState(false);
  const [profileAddress, setProfileAddress] = useState(null);
  const [education,      setEducation]      = useState([]);
  const [occupation,     setOccupation]     = useState([]);
  const [parentOccupations, setParentOccupations] = useState({});

  const dragStart       = useRef({ mx: 0, my: 0, px: 0, py: 0 });
  const exportRef       = useRef();
  const exportPhotosRef = useRef();
  const detailsRef      = useRef();

  // ── Derived ───────────────────────────────────────────────────────────────
  const isProfilePicture = (attachmentId) => profile?.profilePictureId === attachmentId;

  const slotOrder = PHOTO_SLOTS.map(s => s.key);
  const sortedImages = [...images].sort((a, b) => {
    if (isProfilePicture(a.id)) return -1;
    if (isProfilePicture(b.id)) return 1;
    const ai = slotOrder.indexOf(a.category);
    const bi = slotOrder.indexOf(b.category);
    if (ai !== -1 && bi === -1) return -1;
    if (ai === -1 && bi !== -1) return 1;
    if (ai !== -1 && bi !== -1) return ai - bi;
    return 0;
  });

  const profilePhotoAttachment = images.find(img => isProfilePicture(img.id));
  const profilePhotoUrl = profilePhotoAttachment
    ? getImageUrl(profilePhotoAttachment.file_url)
    : null;

  const maritalStatusName = enums?.maritalsts?.map?.[String(profile?.maritalsts)]?.toLowerCase();
  const showChildren = (maritalStatusName === "divorced" || maritalStatusName === "widow") &&
    profile?.childrencount != null && profile?.childrencount !== "";

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  useEffect(() => {
    loadProfile();
    loadImages();
    if (admin) {
      getPlanHistory(id)
        .then(plans => {
          if (Array.isArray(plans) && plans.length > 0) {
            setLatestPlan(plans[0]);
            setPlanHistory(plans);
          }
        })
        .catch(() => {});
    }
  }, [id]);

  useEffect(() => {
    if (!profile?.id || !enums) return;
    getFamily(profile.id).then(async (rows) => {
      const mapped = rows && Array.isArray(rows)
        ? rows.map(r => ({ ...r, relationLabel: enums?.relationtype?.map?.[r.relationtype] }))
        : [];
      setFamily(mapped);
      loadFamilyAddresses(rows);
      const parents = mapped.filter(m => Number(m.relationtype) === 1 || Number(m.relationtype) === 2);
      if (parents.length) {
        const entries = await Promise.all(
          parents.map(async (p) => {
            const occ = await getOccupation("family", p.id);
            return [p.id, Array.isArray(occ) ? occ : []];
          })
        );
        setParentOccupations(Object.fromEntries(entries));
      }
    });
  }, [profile?.id, enums]);

  useEffect(() => {
    const handler = (e) => {
      if (previewIndex === null) return;
      if (e.key === "Escape")     setPreviewIndex(null);
      if (e.key === "ArrowLeft")  setPreviewIndex(i => i > 0 ? i - 1 : i);
      if (e.key === "ArrowRight") setPreviewIndex(i => i < sortedImages.length - 1 ? i + 1 : i);
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [previewIndex, images.length]);

  useEffect(() => { loadFormEnums("profile").then(setEnums); }, []);

  useEffect(() => {
    setZoomed(false);
    setDragPos({ x: 0, y: 0 });
  }, [previewIndex]);

  // ── Data loaders ──────────────────────────────────────────────────────────
  const loadProfile = async () => {
    const [data, addr, edu, occ] = await Promise.all([
      getProfile(id),
      getAddresses("profile", id),
      getEducation(id),
      getOccupation("profile", id),
    ]);
    setProfile(data);
    setProfileAddress(addr || null);
    setEducation(Array.isArray(edu) ? edu : []);
    setOccupation(Array.isArray(occ) ? occ : []);
  };
  const loadImages  = async () => { const imgs = await getAttachments("profile", id); setImages(imgs); };

  const loadFamilyAddresses = async (familyRows) => {
    const map = {};
    for (const f of familyRows) map[f.id] = await getAddresses("family", f.id);
    setFamilyAddresses(map);
  };

  const refreshFamilyAddress = async (familyId) => {
    const updated = await getAddresses("family", familyId);
    setFamilyAddresses(prev => ({ ...prev, [familyId]: updated }));
  };

  // ── Zoom handlers ─────────────────────────────────────────────────────────
  const handleImageDoubleClick = () => {
    if (zoomed) { setZoomed(false); setDragPos({ x: 0, y: 0 }); }
    else setZoomed(true);
  };

  const handleMouseDown = (e) => {
    if (!zoomed) return;
    e.preventDefault();
    setDragging(true);
    dragStart.current = { mx: e.clientX, my: e.clientY, px: dragPos.x, py: dragPos.y };
  };

  const handleMouseMove = (e) => {
    if (!dragging) return;
    setDragPos({
      x: dragStart.current.px + (e.clientX - dragStart.current.mx),
      y: dragStart.current.py + (e.clientY - dragStart.current.my),
    });
  };

  const handleMouseUp = () => setDragging(false);

  const handleTouchStart = (e) => {
    if (!zoomed) return;
    const t = e.touches[0];
    dragStart.current = { mx: t.clientX, my: t.clientY, px: dragPos.x, py: dragPos.y };
    setDragging(true);
  };

  const handleTouchMove = (e) => {
    if (!dragging) return;
    const t = e.touches[0];
    setDragPos({
      x: dragStart.current.px + (t.clientX - dragStart.current.mx),
      y: dragStart.current.py + (t.clientY - dragStart.current.my),
    });
  };

  // ── Export ────────────────────────────────────────────────────────────────
  const showEl = (el) => {
    el.style.position   = "fixed";
    el.style.left       = "0px";
    el.style.top        = "0px";
    el.style.visibility = "visible";
    el.style.zIndex     = "9999";
    el.style.opacity    = "1";
    el.style.pointerEvents = "none";
    el.style.transform  = "translateX(-200%)";
  };

  const hideEl = (el) => {
    el.style.position   = "fixed";
    el.style.left       = "-9999px";
    el.style.top        = "0px";
    el.style.visibility = "hidden";
    el.style.zIndex     = "-1";
    el.style.opacity    = "0";
    el.style.pointerEvents = "none";
    el.style.transform  = "none";
  };

  const imgToBase64 = (src) => new Promise((resolve) => {
    const canvas = document.createElement("canvas");
    const ctx    = canvas.getContext("2d");
    const image  = new Image();
    image.crossOrigin = "anonymous";
    image.onload = () => {
      canvas.width  = image.naturalWidth  || 100;
      canvas.height = image.naturalHeight || 100;
      ctx.drawImage(image, 0, 0);
      try { resolve(canvas.toDataURL("image/jpeg", 0.95)); }
      catch { resolve(null); }
    };
    image.onerror = () => resolve(null);
    setTimeout(() => resolve(null), 5000);
    image.src = src;
  });

  const captureEl = async (el) => {
    showEl(el);
    const imgs = el.querySelectorAll("img");
    await Promise.all(
      Array.from(imgs).map(async (img) => {
        if (!img.src || img.src.startsWith("data:")) return;
        if (img.src.toLowerCase().includes(".svg")) {
          img.style.display = "none";
          return;
        }
        const b64 = await imgToBase64(img.src);
        if (b64) img.src = b64;
        else img.style.display = "none";
      })
    );
    await new Promise(r => requestAnimationFrame(r));
    await new Promise(r => setTimeout(r, 300));
    const dataUrl = await toJpeg(el, {
      quality:         0.98,
      pixelRatio:      3,
      backgroundColor: "#fffdf9",
      style:           { transform: "scale(1)", transformOrigin: "top left" },
    });
    hideEl(el);
    return dataUrl;
  };

  const addJpegToPdf = async (pdf, dataUrl, pageW, pageH, addPage) => {
    const imgEl   = new Image();
    imgEl.src     = dataUrl;
    await new Promise(r => { imgEl.onload = r; });

    const pxPerMm    = (3 * 96) / 25.4;
    const imgNatW    = imgEl.naturalWidth;
    const imgNatH    = imgEl.naturalHeight;
    const renderedH  = (imgNatH / pxPerMm) * (pageW / (imgNatW / pxPerMm));

    if (renderedH <= pageH) {
      if (addPage) pdf.addPage();
      pdf.addImage(dataUrl, "JPEG", 0, 0, pageW, renderedH);
    } else {
      const srcCanvas   = document.createElement("canvas");
      srcCanvas.width   = imgNatW;
      srcCanvas.height  = imgNatH;
      srcCanvas.getContext("2d").drawImage(imgEl, 0, 0);
      const slicePxH    = pageH * pxPerMm;
      let   srcY        = 0;
      let   firstSlice  = true;

      while (srcY < imgNatH) {
        const sliceH  = Math.min(slicePxH, imgNatH - srcY);
        const sc      = document.createElement("canvas");
        sc.width      = imgNatW;
        sc.height     = sliceH;
        sc.getContext("2d").drawImage(srcCanvas, 0, srcY, imgNatW, sliceH, 0, 0, imgNatW, sliceH);
        if (!firstSlice || addPage) pdf.addPage();
        pdf.addImage(sc.toDataURL("image/jpeg", 0.98), "JPEG", 0, 0, pageW, sliceH / pxPerMm);
        srcY       += slicePxH;
        firstSlice  = false;
      }
    }
  };

  const runExport = async (mode) => {
    const el       = exportRef.current;
    const photosEl = exportPhotosRef.current;
    if (!el) return;

    setExporting(true);

    const fileName = `${profile.firstname}_${profile.lastname}_${profile.client_id ?? profile.id}`;

    try {
      const detailsUrl = await captureEl(el);

      if (mode === "pdf") {
        const pdf   = new jsPDF("p", "mm", "a4");
        const pageW = pdf.internal.pageSize.getWidth();
        const pageH = pdf.internal.pageSize.getHeight();

        await addJpegToPdf(pdf, detailsUrl, pageW, pageH, false);

        if (photosEl && images.length > 0) {
          const photosUrl = await captureEl(photosEl);
          await addJpegToPdf(pdf, photosUrl, pageW, pageH, true);
        }

        pdf.save(`${fileName}.pdf`);

      } else {
        // Image export — stitch details + photos
        if (photosEl && images.length > 0) {
          const photosUrl = await captureEl(photosEl);
          const img1 = new Image();
          const img2 = new Image();
          img1.src = detailsUrl;
          img2.src = photosUrl;
          await Promise.all([
            new Promise(r => { img1.onload = r; }),
            new Promise(r => { img2.onload = r; }),
          ]);
          const canvas = document.createElement("canvas");
          canvas.width  = img1.naturalWidth;
          canvas.height = img1.naturalHeight + img2.naturalHeight;
          const ctx = canvas.getContext("2d");
          ctx.drawImage(img1, 0, 0);
          ctx.drawImage(img2, 0, img1.naturalHeight);
          const link    = document.createElement("a");
          link.href     = canvas.toDataURL("image/jpeg", 0.98);
          link.download = `${fileName}.jpg`;
          link.click();
        } else {
          const link    = document.createElement("a");
          link.href     = detailsUrl;
          link.download = `${fileName}.jpg`;
          link.click();
        }
      }

    } catch (err) {
      console.error("Export failed:", err);
      alert("Export failed. Please try again.");
    } finally {
      setExporting(false);
    }
  };

  // ── Copy to clipboard ─────────────────────────────────────────────────────
  const copyDetailsToClipboard = () => {
    if (!profile) return;
    const lines = [];
    lines.push(`👤 *${profile.firstname} ${profile.lastname} ${profile.middlei || ""}${profile.familyname}*`);
    lines.push(`ID: ${profile.client_id ?? profile.id}`);
    lines.push("");
    lines.push("*📌 Profile Details*");
    lines.push(`Birthdate: ${formatDateDMY(profile.birthdate)}`);
    lines.push(`Gender: ${profile.gender === 1 ? "Male" : "Female"}`);
    lines.push(`Birth Time: ${profile.birthtime || "-"}`);
    lines.push(`Birth Place: ${profile.birthplace || "-"}`);
    lines.push(`Family God: ${profile.familygod || "-"}`);
    lines.push(`Height: ${formatHeight(profile.height) || "-"}`);
    lines.push(`Weight: ${profile.weight || "-"}`);
    lines.push(`Marital Status: ${enums?.maritalsts?.map?.[String(profile.maritalsts)] || "-"}`);
    lines.push(`Children Count: ${showChildren ? profile.childrencount : "-"}`);
    lines.push(`Color: ${enums?.color?.map?.[profile.color] || "-"}`);
    lines.push(`Phone: ${profile.phonenumber || "-"}`);
    lines.push(`Email: ${profile.email || "-"}`);
    lines.push("");
    lines.push("Occupation:");
    occupation.forEach((occ, i) => {
      lines.push(`  ${i + 1}. ${occ.occname}${occ.occrole ? ` — ${occ.occrole}` : ""}${occ.compname ? `, ${occ.compname}` : ""}${occ.income ? `, Income: ${occ.income}L/yr` : ""}`);
    });
    lines.push("");
    lines.push("Address:");
    if (profileAddress?.current) {
      const a = profileAddress.current;
      if (a.addone)   lines.push(`  ${a.addone}`);
      if (a.addtwo)   lines.push(`  ${a.addtwo}`);
      if (a.city)     lines.push(`  City: ${a.city}`);
      if (a.state)    lines.push(`  State: ${a.state}`);
      if (a.country)  lines.push(`  Country: ${a.country}`);
      if (a.zipcode)  lines.push(`  Pincode: ${a.zipcode}`);
    } else {
      lines.push("  -");
    }
    lines.push("");
    lines.push("*🎓 Education*");
    education.forEach((edu, i) => {
      lines.push(`  ${i + 1}. ${edu.degree}${edu.fieldstudy ? ` — ${edu.fieldstudy}` : ""}${edu.college ? `, ${edu.college}` : ""}${edu.year ? `, ${edu.year}` : ""}`);
    });
    lines.push("");
    const siblingLines = buildSiblingLines(profile);
    if (siblingLines.length > 0) {
      lines.push("*👨‍👩‍👧 Siblings*");
      siblingLines.forEach(s => lines.push(`${s.label}: ${s.text}`));
      lines.push("");
    }
    lines.push(`Has Twin: ${formatTwin(profile.hastwin) || "-"}`);
    lines.push("");
    if (family && family.length > 0) {
      lines.push("*🏠 Family Members and address*");
      family.forEach((member, index) => {
        lines.push(`\n${index + 1}. ${[member.firstname, member.lastname].filter(Boolean).join(" ") || "-"} (${member.relationLabel || "-"})`);
        const addresses = familyAddresses?.[member.id];
        if (addresses?.current) {
          const a = addresses.current;
          lines.push(`   📍 Current Address:`);
          if (a.addone)   lines.push(`      ${a.addone}`);
          if (a.city)     lines.push(`      City: ${a.city}`);
          if (a.state)    lines.push(`      State: ${a.state}`);
          if (a.country)  lines.push(`      Country: ${a.country}`);
          if (a.zipcode)  lines.push(`      Pincode: ${a.zipcode}`);
        }
      });
      lines.push("");
    }
    navigator.clipboard.writeText(lines.join("\n"))
      .then(() => alert("Full profile copied!"))
      .catch(() => alert("Copy failed"));
  };

  // ── Family CRUD ───────────────────────────────────────────────────────────
  const saveFamily = async (data) => {
    if (editingFamily) await updateFamily(editingFamily.id, data);
    else await addFamily(profile.id, data);
    setEditingFamily(null);
    setShowFamilyForm(false);
    const rows = await getFamily(profile.id);
    setFamily(rows.map(r => ({ ...r, relationLabel: enums?.relationtype?.map?.[r.relationtype] })));
    loadFamilyAddresses(rows);
  };

  const removeFamily = async (fid) => {
    await deleteFamily(fid);
    setFamily(family.filter(f => f.id !== fid));
  };

  // ── Plan actions ──────────────────────────────────────────────────────────
  const refreshPlanData = async () => {
    const plans = await getPlanHistory(id);
    if (Array.isArray(plans) && plans.length > 0) {
      setLatestPlan(plans[0]);
      setPlanHistory(plans);
    }
  };

  const handleAssignPlan = async () => {
    if (latestPlan) {
      const confirmed = window.confirm(
        `This profile already has a ${subLabel[latestPlan.subscription_name]} (${latestPlan.payment_status}) plan expiring on ${new Date(latestPlan.plan_expiry).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}.\nAssign a new ${subLabel[selectedPlan]} plan anyway?`
      );
      if (!confirmed) return;
    }
    setPlanSaving(true);
    try {
      const res = await assignPlan(id, selectedPlan);
      if (res.success) await refreshPlanData();
      else alert("Failed to assign plan");
    } catch { alert("Failed to assign plan"); }
    finally { setPlanSaving(false); }
  };

  const handleConfirmPayment = async () => {
    if (!window.confirm("Confirm payment received?")) return;
    try {
      const res = await confirmPayment(id);
      if (res.success) await refreshPlanData();
      else alert("Failed to confirm payment");
    } catch { alert("Failed to confirm payment"); }
  };

  // ── Upload ────────────────────────────────────────────────────────────────
  const upload = async () => {
    if (!files.length) return;
    setUploading(true);
    await uploadAttachments("profile", id, files);
    setFiles([]);
    await loadImages();
    setUploading(false);
  };

  const uploadSlotImage = async (file, photoType) => {
    if (!file) return;
    await uploadAttachments("profile", id, file, photoType);
    await loadImages();
  };

  const handleDeleteAttachment = async (attachmentId) => {
    if (!window.confirm("Are you sure you want to delete this photo?")) return;
    try {
      await deleteAttachments(attachmentId);
      await loadImages();
    } catch (err) {
      alert(err.response?.data?.message || "Delete failed");
    }
  };

  const handleSetProfilePicture = async (attachmentId) => {
    if (!profile?.id) return;
    setProfile(prev => ({ ...prev, profilePictureId: attachmentId }));
    try {
      await setProfilePictureApi(profile.id, attachmentId);
    } catch {
      alert("Failed to set profile picture");
    }
  };

  // ── Guard ─────────────────────────────────────────────────────────────────
  if (!profile || !enums) return (
    <div style={{ display: "flex", alignItems: "center", justifyContent: "center", minHeight: "60vh" }}>
      <div className="ps-spinner" />
    </div>
  );

  // ─────────────────────────────────────────────────────────────────────────
  return (
    <>
      {/* Hidden export layouts */}
      <div
        ref={exportRef}
        style={{ position: "fixed", left: "-9999px", top: "0px", visibility: "hidden", zIndex: -1, opacity: 0, pointerEvents: "none" }}
      >
        <ExportLayoutDetails
          profile={profile}
          enums={enums}
          family={family}
          familyAddresses={familyAddresses}
          profilePhotoUrl={profilePhotoUrl}
          profileAddress={profileAddress}
          education={education}
          occupation={occupation}
          parentOccupations={parentOccupations}
        />
      </div>

      <div
        ref={exportPhotosRef}
        style={{ position: "fixed", left: "-9999px", top: "0px", visibility: "hidden", zIndex: -1, opacity: 0, pointerEvents: "none" }}
      >
        <ExportLayoutPhotos
          profile={profile}
          profilePhotoUrl={profilePhotoUrl}
          allImages={sortedImages}
        />
      </div>

      <div style={{ padding: "36px 40px", animation: "fadeIn .3s ease both" }}>
        <div style={{ display: "grid", gridTemplateColumns: "42% 1fr", gap: "28px", alignItems: "start" }}>

          {/* ══ LEFT — IMAGE GRID ══ */}
          <div>
            <div className="image-grid" style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "8px" }}>
              {sortedImages.map((img, index) => {
                const isPfp          = isProfilePicture(img.id);
                const slotBadge      = !isPfp && img.category ? SLOT_BADGE[img.category] : null;
                const showSetProfile = !isPfp && canSetAsProfile(img.category);
                return (
                  <div
                    key={img.id}
                    className={`image-tile ${isPfp ? "profile-image" : ""}`}
                    style={{ aspectRatio: "4 / 5" }}
                    onClick={() => setPreviewIndex(index)}
                  >
                    <img src={getImageUrl(img.file_url)} alt="Profile" />
                    {slotBadge && (
                      <div style={{ position: "absolute", top: 0, left: 0, right: 0, height: "3px", background: GRADIENT, pointerEvents: "none" }} />
                    )}
                    {isPfp && <span className="profile-badge">Profile</span>}
                    {slotBadge && (
                      <span style={{
                        position: "absolute", top: "8px", left: "8px",
                        background: GRADIENT, color: "#fff",
                        fontSize: "9.5px", fontWeight: 700, letterSpacing: ".06em",
                        textTransform: "uppercase", padding: "3px 9px",
                        borderRadius: "999px", boxShadow: "0 2px 6px rgba(0,0,0,.28)",
                        pointerEvents: "none",
                      }}>
                        {slotBadge}
                      </span>
                    )}
                    {showSetProfile && (
                      <button className="set-profile-btn" onClick={e => { e.stopPropagation(); handleSetProfilePicture(img.id); }}>
                        Set as Profile
                      </button>
                    )}
                    {!isPfp && (
                      <button
                        className="delete-image-btn"
                        style={{ color: "#fff" }}
                        onClick={e => { e.stopPropagation(); handleDeleteAttachment(img.id); }}
                      >
                        Delete
                      </button>
                    )}
                  </div>
                );
              })}
            </div>

            {/* Upload area */}
            <div
              className={`upload-dropzone ${isDragging ? "dragging" : ""}`}
              onDragOver={e => { e.preventDefault(); setIsDragging(true); }}
              onDragLeave={e => { e.preventDefault(); setIsDragging(false); }}
              onDrop={e => { e.preventDefault(); setIsDragging(false); setFiles(e.dataTransfer.files); }}
              style={{ marginTop: "14px" }}
            >
              <div style={{ marginBottom: "6px" }}>
                {<span style={{ fontSize: "12px", fontWeight: 700, color: "var(--ink-2)" }}>Profile Gallery</span>}
                {<span style={{ fontSize: "11px", color: "var(--ink-4)", marginLeft: "6px" }}>portraits, candid shots, etc.</span>}
              </div>
              <p style={{ fontSize: "13px", color: "var(--ink-3)" }}>Accepted Filetype jpeg,jpg,png</p>
              <p style={{ fontSize: "13px", color: "var(--ink-3)" }}>Drag & drop images here</p>
              <p style={{ fontSize: "12px", color: "var(--ink-4)", margin: "4px 0" }}>or</p>
              <input type="file" multiple accept="image/*" onChange={e => setFiles(e.target.files)} />
              <button
                onClick={upload}
                disabled={uploading || !files.length}
                style={{
                  marginTop: "10px", padding: "9px 24px", border: "none",
                  borderRadius: "var(--r-sm)",
                  background: uploading || !files.length ? "var(--border)" : "linear-gradient(110deg, var(--amber), var(--rose-light))",
                  color: uploading || !files.length ? "var(--ink-4)" : "#fff",
                  fontSize: "13px", fontWeight: 700,
                  cursor: uploading || !files.length ? "not-allowed" : "pointer",
                  transition: "all 160ms ease"
                }}
              >
                {uploading ? "Uploading..." : "Upload Images"}
              </button>
              <br />
              <div className="upload-dropzone">
                <h3 className="section-title">------------ Upload Photos --------------</h3>
                {PHOTO_SLOTS.map((slot) => (
                  <div key={slot.key} className="upload-slot">
                    <label className="upload-label">
                      {slot.label}
                      {slot.required && <span className="required">*</span>}
                    </label>
                    <input
                      type="file"
                      accept="image/*"
                      onChange={(e) => uploadSlotImage(e.target.files[0], slot.key)}
                    />
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* ══ RIGHT — DETAILS ══ */}
          <div ref={detailsRef} style={{ display: "flex", flexDirection: "column", gap: "20px" }}>

            {/* Name + actions */}
            <div style={{
              background: "var(--surface)", border: "1px solid var(--border)",
              borderRadius: "var(--r-lg)", padding: "28px 32px",
              boxShadow: "var(--shadow-sm)", position: "relative", overflow: "hidden",
              animation: "slideRight .5s var(--smooth) .1s both"
            }}>
              <button
                onClick={copyDetailsToClipboard}
                style={{
                  position: "absolute", top: "12px", right: "12px",
                  padding: "6px 12px", fontSize: "12px",
                  borderRadius: "6px", border: "1px solid var(--border)",
                  background: "var(--bg)", cursor: "pointer"
                }}
              >
                📋 Copy
              </button>
              <div style={{ position: "absolute", top: 0, left: 0, right: 0, height: "3px", background: "linear-gradient(90deg, var(--amber), var(--rose-light))" }} />
              <h1 style={{ fontFamily: "var(--font-display)", fontSize: "32px", fontWeight: 400, fontStyle: "italic", color: "var(--ink)", lineHeight: 1.1, marginBottom: "2px" }}>
                <Link to={`/profiles/${profile.id}/edit`} style={{ textDecoration: "none", color: "inherit" }}>
                  {profile.firstname} {profile.lastname} {profile.middlei} {profile.familyname}
                </Link>
              </h1>
              <div style={{ fontSize: "13px", color: "var(--ink-3)", marginBottom: "4px" }}>
                Client-ID:-{profile.client_id ?? `#${profile.id}`} · {profile.familynames}
              </div>
              <div style={{ height: "2px", background: "linear-gradient(90deg, var(--amber), var(--rose-light), transparent)", borderRadius: "9999px", marginBottom: "18px" }} />
              <div style={{ display: "flex", gap: "8px", flexWrap: "wrap" }}>
                {[
                  { to: `/profiles/${profile.id}/edit`,        label: "✎ Edit Profile" },
                  { to: `/profiles/${profile.id}/preferences`, label: "⚙ Preferences", state: { fromProfile: location.pathname } },
                  { to: `/profiles/${profile.id}/match`,       label: "⟳ Find Matches", state: { fromProfile: location.pathname } }
                ].map(link => (
                  <Link key={link.to} to={link.to} state={link.state} style={{
                    padding: "7px 16px", borderRadius: "var(--r-sm)",
                    border: "1.5px solid var(--border)", background: "var(--bg)",
                    color: "var(--ink-3)", fontSize: "12.5px", fontWeight: 600,
                    textDecoration: "none", transition: "all 160ms ease",
                    display: "inline-flex", alignItems: "center", gap: "5px"
                  }}
                    onMouseEnter={e => { e.currentTarget.style.borderColor = "var(--amber)"; e.currentTarget.style.color = "var(--amber)"; e.currentTarget.style.background = "var(--amber-dim)"; }}
                    onMouseLeave={e => { e.currentTarget.style.borderColor = "var(--border)"; e.currentTarget.style.color = "var(--ink-3)"; e.currentTarget.style.background = "var(--bg)"; }}
                  >
                    {link.label}
                  </Link>
                ))}
              </div>
            </div>

            {/* Profile Details */}
            <div style={{
              background: "var(--surface)", border: "1px solid var(--border)",
              borderRadius: "var(--r-lg)", padding: "24px 28px", boxShadow: "var(--shadow-sm)"
            }}>
              <SectionLabel>Profile Details</SectionLabel>
              <div style={{ display: "flex", flexDirection: "column", gap: "4px", marginBottom: "14px" }}>
                <Attr label="Birthdate"      value={formatDateDMY(profile.birthdate)} />
                <Attr label="Age"            value={calculateAge(profile.birthdate)} />
                <Attr label="Gender"         value={profile.gender === 1 ? "Male" : "Female"} />
                <Attr label="Birthtime"      value={profile.birthtime} />
                <Attr label="Birthplace"     value={profile.birthplace} />
                <Attr label="Height"         value={formatHeight(profile.height)} />
                <Attr label="Weight"         value={profile.weight} />
                <Attr label="Phone"          value={profile.phonenumber} />
                <Attr label="Email"          value={profile.email} />
                <Attr label="Color"          value={enums?.color?.map?.[profile.color]} />
                <Attr label="Birth Star"     value={enums?.birthstar?.map?.[profile.birthstar]} />
                <Attr label="Pada"           value={enums?.birthpada?.map?.[profile.starpada]} />
                <Attr label="Birth Rashi"    value={enums?.birthrasi?.map?.[profile.birthrasi]} />
                <Attr label="Marital Status" value={enums?.maritalsts?.map?.[String(profile.maritalsts)]} />
                {showChildren && <Attr label="Children" value={profile.childrencount} />}
                <Attr label="Swagothra"      value={profile?.swagothranm?.gothraname} />
                <Attr label="Mamagothra"     value={profile?.mamagothranm?.gothraname} />
              </div>

              {/* Education */}
              <div className="pf-card">
                <div className="pf-card-header">
                  <h2 className="pf-card-title">Education</h2>
                  <p className="pf-card-sub">Add and manage education details</p>
                </div>
                <EducationSection profile_id={id} />
              </div>

              <AddressSection
                relationtype="profile"
                relationid={profile.id}
                familyids={family
                  .filter(m => Number(m.relationtype) === 1 || Number(m.relationtype) === 2)
                  .map(m => m.id)}
              />

              <div style={{
                marginTop: "12px", padding: "16px 20px",
                border: "1px solid var(--border)", borderRadius: "var(--r-sm)", background: "var(--bg)"
              }}>
                <OccupationSection parenttype="profile" parentid={profile.id} />
              </div>

              <SectionLabel>Asset and Income Details</SectionLabel>
              <div style={{ display: "flex", flexDirection: "column", gap: "4px", marginBottom: "14px" }}>
                <Attr label="Asset Details"  value={profile.assetdets} />
                <Attr label="Asset Value"    value={profile.networth} />
                <Attr label="Annual Income"  value={profile.income} />
              </div>
            </div>

            {/* Family Details */}
            <div style={{ background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-lg)", padding: "24px 28px", boxShadow: "var(--shadow-sm)" }}>
              <SectionLabel>Family Details</SectionLabel>
              {(() => {
                const lines = buildSiblingLines(profile);
                return lines.length > 0 ? (
                  <div style={{ display: "flex", flexDirection: "column", gap: "4px", marginBottom: "4px" }}>
                    {lines.map(({ label, text }) => (
                      <div key={label} style={{
                        padding: "5px 12px", background: "var(--bg)",
                        borderRadius: "var(--r-sm)", border: "1px solid var(--border)",
                        fontSize: "12.5px", color: "var(--ink-2)",
                        display: "flex", alignItems: "center", gap: "10px",
                        transition: "border-color 160ms ease, transform 160ms ease",
                      }}
                        onMouseEnter={e => { e.currentTarget.style.borderColor = "var(--amber)"; e.currentTarget.style.transform = "translateX(4px)"; }}
                        onMouseLeave={e => { e.currentTarget.style.borderColor = "var(--border)"; e.currentTarget.style.transform = "translateX(0)"; }}
                      >
                        <span style={{ fontSize: "9.5px", fontWeight: 700, letterSpacing: ".08em", textTransform: "uppercase", color: "var(--amber)", minWidth: "90px", flexShrink: 0 }}>
                          {label}
                        </span>
                        {text}
                      </div>
                    ))}
                  </div>
                ) : null;
              })()}
              <div style={{ display: "flex", flexDirection: "column", gap: "4px", marginBottom: "12px" }}>
                <Attr label="Has Twin?" value={formatTwin(profile.hastwin)} />
              </div>
              <FamilyList
                members={family}
                addresses={familyAddresses}
                onAdd={() => { setEditingFamily(null); setShowFamilyForm(true); }}
                onEdit={m => { setEditingFamily(m); setShowFamilyForm(true); }}
                onDelete={removeFamily}
                onRefreshAddress={refreshFamilyAddress}
              />
              {showFamilyForm && (
                <FamilyForm
                  value={editingFamily}
                  enums={enums}
                  onSave={saveFamily}
                  onCancel={() => { setEditingFamily(null); setShowFamilyForm(false); }}
                />
              )}
            </div>

            {/* Subscription Plan — admin only */}
            {admin && (
              <div style={{ background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-lg)", padding: "24px 28px", boxShadow: "var(--shadow-sm)" }}>
                <SectionLabel>Subscription Plan</SectionLabel>
                {latestPlan && (
                  <div style={{ marginBottom: "20px", padding: "14px 16px", background: "var(--bg)", borderRadius: "var(--r-sm)", border: "1px solid var(--border)", display: "flex", gap: "16px", flexWrap: "wrap", alignItems: "center" }}>
                    <div>
                      <span style={{ fontSize: "12px", color: "var(--ink-3)" }}>Current Plan</span>
                      <div style={{ display: "flex", gap: "8px", alignItems: "center", marginTop: "4px" }}>
                        <span className="badge badge-neutral">{subLabel[latestPlan.subscription_name] || latestPlan.subscription_name}</span>
                        <span className={`badge ${colorMap[latestPlan.payment_status] || "badge-neutral"}`}>
                          {latestPlan.payment_status?.charAt(0).toUpperCase() + latestPlan.payment_status?.slice(1)}
                        </span>
                      </div>
                    </div>
                    {latestPlan.plan_expiry && (
                      <div>
                        <span style={{ fontSize: "12px", color: "var(--ink-3)" }}>Expires</span>
                        <div style={{ fontSize: "13px", fontWeight: 500, marginTop: "4px" }}>
                          {new Date(latestPlan.plan_expiry).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}
                        </div>
                      </div>
                    )}
                    {latestPlan.payment_confirmed_at && (
                      <div>
                        <span style={{ fontSize: "12px", color: "var(--ink-3)" }}>Paid On</span>
                        <div style={{ fontSize: "13px", fontWeight: 500, marginTop: "4px" }}>
                          {new Date(latestPlan.payment_confirmed_at).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}
                        </div>
                      </div>
                    )}
                    {latestPlan.payment_status === "unpaid" && (
                      <button type="button" className="ps-action-btn"
                        style={{ background: "var(--teal)", color: "#fff", border: "none", marginLeft: "auto" }}
                        onClick={handleConfirmPayment}>
                        ✓ Confirm Payment
                      </button>
                    )}
                  </div>
                )}
                <div style={{ display: "flex", gap: "12px", alignItems: "flex-end", flexWrap: "wrap", marginBottom: "16px" }}>
                  <div>
                    <label style={{ fontSize: "12px", color: "var(--ink-3)", display: "block", marginBottom: "6px" }}>Assign New Plan</label>
                    <select className="pf-input pf-select" value={selectedPlan} onChange={e => setSelectedPlan(e.target.value)}>
                      {SUBSCRIPTION_PLANS.map(p => (
                        <option key={p.name} value={p.name}>{p.label} — {p.duration}</option>
                      ))}
                    </select>
                  </div>
                  <button type="button" className="ps-search-btn" onClick={handleAssignPlan} disabled={planSaving}>
                    {planSaving ? "Assigning..." : "Assign Plan"}
                  </button>
                </div>
                {planHistory.length > 0 && (
                  <div>
                    <button type="button" className="btn-secondary" onClick={() => setShowHistory(h => !h)}>
                      {showHistory ? "Hide History" : `View History (${planHistory.length})`}
                    </button>
                    {showHistory && (
                      <div style={{ marginTop: "12px", display: "flex", flexDirection: "column", gap: "8px" }}>
                        {planHistory.map((plan, i) => (
                          <div key={plan.id} style={{ padding: "12px 14px", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", background: i === 0 ? "var(--bg)" : "transparent" }}>
                            <div style={{ display: "flex", gap: "8px", alignItems: "center", marginBottom: "4px" }}>
                              <span className={`badge ${colorMap[plan.payment_status] || "badge-neutral"}`}>
                                {plan.payment_status?.charAt(0).toUpperCase() + plan.payment_status?.slice(1)}
                              </span>
                              <span style={{ fontSize: "13px", fontWeight: 500 }}>{subLabel[plan.subscription_name] || plan.subscription_name}</span>
                              {i === 0 && <span style={{ fontSize: "11px", color: "var(--ink-3)", marginLeft: "auto" }}>Latest</span>}
                            </div>
                            <div style={{ fontSize: "12px", color: "var(--ink-2)", display: "flex", gap: "12px" }}>
                              <span>Start: {new Date(plan.plan_start).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}</span>
                              <span>Expiry: {new Date(plan.plan_expiry).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}</span>
                            </div>
                            {(plan.payment_status === "paid" || plan.payment_status === "expiring") && plan.payment_confirmed_at && (
                              <div style={{ fontSize: "12px", color: "var(--ink-3)", marginTop: "4px" }}>
                                Paid on: {new Date(plan.payment_confirmed_at).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}
                              </div>
                            )}
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}

            {/* Export buttons */}
            <div style={{ display: "flex", gap: "10px" }}>
              {[
                { label: "Export PDF",   action: () => runExport("pdf"),   icon: "↓", disabled: exporting },
                { label: "Export Image", action: () => runExport("image"), icon: "⬡", disabled: exporting },
              ].map(btn => (
                <button
                  key={btn.label}
                  onClick={btn.action}
                  disabled={btn.disabled}
                  className="btn-secondary"
                  style={{
                    padding: "10px 22px", fontSize: "13px",
                    display: "inline-flex", alignItems: "center", gap: "6px",
                    opacity: btn.disabled ? 0.6 : 1,
                    cursor: btn.disabled ? "not-allowed" : "pointer",
                  }}
                >
                  <span>{btn.icon}</span>
                  {exporting ? "Exporting..." : btn.label}
                </button>
              ))}
            </div>

          </div>
        </div>

        {/* Image preview modal */}
        {previewIndex !== null && (
          <div
            className="image-modal-overlay"
            style={{ zIndex: 2100, position: "fixed", inset: 0 }}
            onClick={() => { if (!zoomed) setPreviewIndex(null); }}
          >
            <div
              className="image-modal-content"
              onClick={e => e.stopPropagation()}
              onMouseMove={handleMouseMove}
              onMouseUp={handleMouseUp}
              onMouseLeave={handleMouseUp}
              onTouchMove={handleTouchMove}
              onTouchEnd={() => setDragging(false)}
            >
              <button className="modal-close" onClick={() => setPreviewIndex(null)}>✕</button>

              {(() => {
                const img   = sortedImages[previewIndex];
                const label = isProfilePicture(img?.id)
                  ? "Profile"
                  : (img?.category ? SLOT_BADGE[img.category] : null);
                return label ? (
                  <div style={{
                    position: "absolute", top: "14px", left: "14px",
                    background: GRADIENT, color: "#fff",
                    fontSize: "10px", fontWeight: 700, letterSpacing: ".07em",
                    textTransform: "uppercase", padding: "4px 10px",
                    borderRadius: "999px", zIndex: 2,
                    boxShadow: "0 2px 8px rgba(0,0,0,.3)",
                  }}>
                    {label}
                  </div>
                ) : null;
              })()}

              <div style={{
                position: "absolute", top: "14px", right: "48px",
                fontSize: "10px", color: "rgba(255,255,255,.5)",
                fontWeight: 500, letterSpacing: ".04em", zIndex: 2, userSelect: "none",
              }}>
                {zoomed ? "Double-click to zoom out" : "Double-click to zoom in"}
              </div>

              <div
                className="image-modal-zoom-wrap"
                style={{ overflow: "hidden", cursor: zoomed ? (dragging ? "grabbing" : "grab") : "zoom-in" }}
              >
                <img
                  src={getImageUrl(sortedImages[previewIndex]?.file_url)}
                  alt="Preview"
                  draggable={false}
                  onDoubleClick={handleImageDoubleClick}
                  onMouseDown={handleMouseDown}
                  onTouchStart={handleTouchStart}
                  style={{
                    transform: zoomed
                      ? `scale(2.5) translate(${dragPos.x / 2.5}px, ${dragPos.y / 2.5}px)`
                      : "scale(1) translate(0,0)",
                    transition: dragging ? "none" : "transform 260ms ease",
                    userSelect: "none",
                    WebkitUserDrag: "none",
                  }}
                />
              </div>

              <div style={{ position: "absolute", bottom: "-52px", left: "50%", transform: "translateX(-50%)", display: "flex", alignItems: "center", gap: "12px" }}>
                <button onClick={() => setPreviewIndex(i => i > 0 ? i - 1 : i)} className="modal-zoom-btn" disabled={previewIndex === 0} style={{ opacity: previewIndex === 0 ? 0.4 : 1 }}>←</button>
                <span style={{ fontSize: "12px", fontWeight: 600, color: "var(--ink-3)", minWidth: "60px", textAlign: "center" }}>
                  {previewIndex + 1} / {sortedImages.length}
                </span>
                <button onClick={() => setPreviewIndex(i => i < sortedImages.length - 1 ? i + 1 : i)} className="modal-zoom-btn" disabled={previewIndex === sortedImages.length - 1} style={{ opacity: previewIndex === sortedImages.length - 1 ? 0.4 : 1 }}>→</button>
              </div>
            </div>
          </div>
        )}
      </div>
    </>
  );
}