import { useEffect, useState, useRef, useCallback } from "react";
import { getGothras } from "../../logic/gothras.logic";
import { getCountries, getAddresses } from "../../logic/address.logic";
import { useNavigate, useLocation, Link } from "react-router-dom";
import { searchProfiles, changests, searchProfilesAdmin, assignPlan, confirmPayment, getPlanHistory } from "../../logic/profiles.logic";
import { loadFormEnums } from "../../logic/enumStore";
import { useAuth } from "../../auth/AuthContext";
import { getEducation } from "../../logic/education.logic";
import { HeightPicker } from "./ProfileForm";
import { BASE_URL, COMPANY } from "../../api/apiClient";
import { toJpeg } from 'html-to-image';
import { createRoot } from "react-dom/client";

const getImageUrl = (url) => {
  if (!url) return "/assets/defaultProfile.png";

  if (url.startsWith("http")) {
    return url;
  }

  return `${BASE_URL}${url}`;
};

// ─── Height helpers ───────────────────────────────────────────────────────────
const feetInchesToCm = (feet, inches) => {
  const f = parseInt(feet)   || 0;
  const i = parseInt(inches) || 0;
  if (feet === "" && inches === "") return "";
  return ((f * 12 + i) * 2.54).toFixed(2);
};

const cmToFeetInches = (cm) => {
  if (!cm && cm !== 0) return { feet: "", inches: "" };
  const total  = parseFloat(cm) / 2.54;
  const feet   = Math.floor(total / 12);
  const inches = Math.round(total % 12);
  if (inches === 12) return { feet: feet + 1, inches: 0 };
  return { feet, inches };
};

const formatHeight = (cm) => {
  if (!cm) return null;
  const { feet, inches } = cmToFeetInches(cm);
  return `${feet}'${inches}"`;
};

const calcAge = (birthdate) => {
  if (!birthdate) return null;
  return Math.floor((new Date() - new Date(birthdate)) / (365.25 * 24 * 60 * 60 * 1000));
};
// ─────────────────────────────────────────────────────────────────────────────

const daysUntilExpiry = (d) =>
  d ? Math.ceil((new Date(d) - new Date()) / 86400000) : null;

// ─── PaymentBadge ─────────────────────────────────────────────────────────────
const PaymentBadge = ({ status, expiryDate }) => {
  const days      = daysUntilExpiry(expiryDate);
  const showAlert = days !== null && days <= 15 && days >= 0;
  const colorMap  = { paid: "badge-teal", expiring: "badge-amber", expired: "badge-neutral", unpaid: "badge-neutral" };
  return (
    <div style={{ display: "flex", alignItems: "center", gap: "6px" }}>
      <span className={`badge ${colorMap[status] || "badge-neutral"}`}>
        {status?.charAt(0).toUpperCase() + status?.slice(1) || "No Plan"}
      </span>
      {showAlert && (
        <span title={`Expires in ${days} day(s)`} style={{ color: "#d97706", fontSize: "12px" }}>⚠️ {days}d</span>
      )}
    </div>
  );
};

// ─── Plan History Modal ───────────────────────────────────────────────────────
function PlanHistoryModal({ profile, onClose }) {
  const [plans,   setPlans]   = useState([]);
  const [loading, setLoading] = useState(true);
  const subLabel = { bronze: "Bronze", silver: "Silver", gold: "Gold", diamond: "Diamond" };
  const colorMap = { paid: "badge-teal", expiring: "badge-amber", expired: "badge-neutral", unpaid: "badge-neutral" };

  useEffect(() => {
    getPlanHistory(profile.id)
      .then(data => { setPlans(Array.isArray(data) ? data : []); setLoading(false); })
      .catch(() => setLoading(false));
  }, [profile.id]);

  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.4)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 1000 }}>
      <div style={{ background: "var(--surface)", borderRadius: "var(--r-lg)", padding: "28px", width: "500px", maxWidth: "90vw", maxHeight: "80vh", overflowY: "auto", boxShadow: "0 8px 32px rgba(0,0,0,0.18)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "20px" }}>
          <div>
            <h3 style={{ margin: 0, fontSize: "16px", fontWeight: 600 }}>Plan History</h3>
            <p style={{ margin: "2px 0 0", fontSize: "13px", color: "var(--ink-3)" }}>{profile.firstname} {profile.lastname}</p>
          </div>
          <button className="btn-secondary" onClick={onClose}>✕</button>
        </div>
        {loading
          ? <div style={{ textAlign: "center", padding: "32px" }}><div className="ps-spinner" /></div>
          : plans.length === 0
            ? <p style={{ color: "var(--ink-3)", textAlign: "center", padding: "32px 0" }}>No plans found</p>
            : (
              <div style={{ display: "flex", flexDirection: "column", gap: "10px" }}>
                {plans.map((plan, i) => (
                  <div key={plan.id} style={{ padding: "14px 16px", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", background: i === 0 ? "var(--bg)" : "transparent" }}>
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "6px" }}>
                      <div style={{ display: "flex", gap: "8px", alignItems: "center" }}>
                        <span className={`badge ${colorMap[plan.payment_status] || "badge-neutral"}`}>
                          {plan.payment_status?.charAt(0).toUpperCase() + plan.payment_status?.slice(1)}
                        </span>
                        <span style={{ fontSize: "13px", fontWeight: 500 }}>{subLabel[plan.subscription_name] || plan.subscription_name}</span>
                      </div>
                      {i === 0 && <span style={{ fontSize: "11px", color: "var(--ink-3)" }}>Latest</span>}
                    </div>
                    <div style={{ fontSize: "13px", color: "var(--ink-2)", display: "flex", gap: "16px" }}>
                      <span>Start: <strong>{new Date(plan.plan_start).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}</strong></span>
                      <span>Expiry: <strong>{new Date(plan.plan_expiry).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}</strong></span>
                    </div>
                    {(plan.payment_status === "paid" || plan.payment_status === "expiring") && plan.payment_confirmed_at && (
                      <div style={{ fontSize: "12px", color: "var(--ink-3)", marginTop: "4px" }}>
                        Paid on: {new Date(plan.payment_confirmed_at).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}
                      </div>
                    )}
                  </div>
                ))}
              </div>
            )
        }
      </div>
    </div>
  );
}

// ─── Photo Modal with double-tap / double-click zoom ─────────────────────────
// (uses educationMap + enums for richer profile info overlay — from File 2)
function PhotoModal({ profiles, index, onClose, onNavigate, gothras, enums, educationMap }) {
  const [zoomed, setZoomed]   = useState(false);
  const [zoomPos, setZoomPos] = useState({ x: 50, y: 50 });
  const lastTap               = useRef(0);
  const imgRef                = useRef(null);
  const p                     = profiles[index];

  useEffect(() => {
    const handler = (e) => {
      if (e.key === "Escape")                                       { onClose(); }
      if (e.key === "ArrowLeft"  && index > 0)                     { onNavigate(index - 1); }
      if (e.key === "ArrowRight" && index < profiles.length - 1)   { onNavigate(index + 1); }
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [index, onClose, onNavigate, profiles.length]);

  useEffect(() => { setZoomed(false); }, [index]);

  const triggerZoom = useCallback((clientX, clientY) => {
    if (!zoomed && imgRef.current) {
      const rect = imgRef.current.getBoundingClientRect();
      setZoomPos({
        x: ((clientX - rect.left) / rect.width)  * 100,
        y: ((clientY - rect.top)  / rect.height) * 100,
      });
    }
    setZoomed(z => !z);
  }, [zoomed]);

  const handleDoubleClick = (e) => { e.stopPropagation(); triggerZoom(e.clientX, e.clientY); };

  const handleTouchEnd = useCallback((e) => {
    const now = Date.now();
    if (now - lastTap.current < 300) {
      e.preventDefault();
      const t = e.changedTouches[0];
      triggerZoom(t.clientX, t.clientY);
    }
    lastTap.current = now;
  }, [triggerZoom]);

  if (!p) return null;

  const age        = calcAge(p.birthdate);
  const gothraName = gothras.find(g => String(g.id) === String(p.swagothra))?.gothraname
                     || p.swagothranm?.gothraname
                     || null;
  const birthstarName = enums?.birthstar?.options?.find(
                          o => String(o.enumvalue) === String(p.birthstar)
                        )?.strvalue || null;

  const occupation = p.occupations?.[0];

  return (
    <div
      onClick={() => { if (zoomed) setZoomed(false); else onClose(); }}
      style={{
        position: "fixed", inset: 0, zIndex: 2000,
        background: "rgba(0,0,0,0.92)",
        display: "flex", flexDirection: "column",
        alignItems: "center", justifyContent: "center",
        padding: "16px",
      }}
    >
      <button
        onClick={(e) => { e.stopPropagation(); onClose(); }}
        style={{
          position: "absolute", top: "16px", right: "16px",
          background: "rgba(255,255,255,0.12)", border: "none", borderRadius: "50%",
          width: "36px", height: "36px", fontSize: "18px", color: "#fff",
          cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 10,
        }}
      >✕</button>

      <Link
        to={`/profiles/${p.id}`}
        target="_blank"
        onClick={e => e.stopPropagation()}
        style={{ textDecoration: "none", textAlign: "center", marginBottom: "14px" }}
      >
        <p style={{ margin: "0 0 4px", fontSize: "20px", fontWeight: 600, color: "#fff", lineHeight: 1.2 }}>
          {p.firstname} {p.lastname}
          <span style={{ fontSize: "13px", fontWeight: 400, opacity: 0.6, marginLeft: "8px" }}>#{p.client_id}</span>
        </p>
        <p style={{ margin: "0 0 3px", fontSize: "13px", color: "rgba(255,255,255,0.75)" }}>
          {p.birthdate
            ? `${new Date(p.birthdate).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}${age ? ` (${age} yrs)` : ""}`
            : ""}
          {p.height ? ` · ${formatHeight(p.height)}` : ""}
        </p>
        <p style={{ margin: "0 0 3px", fontSize: "13px", color: "rgba(255,255,255,0.75)" }}>
          {(educationMap?.[p.id]?.length > 0)
            ? educationMap[p.id].map(e => e.degree).filter(Boolean).join(" · ")
            : "—"}
        </p>
        {gothraName && (
          <p style={{ margin: 0, fontSize: "12px", color: "rgba(255,255,255,0.42)" }}>{gothraName}</p>
        )}
        {(birthstarName || enums?.birthrasi?.map?.[p.birthrasi]) && (
          <p style={{ margin: 0, fontSize: "12px", color: "rgba(255,255,255,0.42)" }}>
            {[birthstarName, enums?.birthrasi?.map?.[p.birthrasi]].filter(Boolean).join(" · ")}
          </p>
        )}
        <p style={{ margin: "0 0 3px", fontSize: "13px", color: "rgba(255,255,255,0.75)" }}>
          {occupation
            ? `${occupation.occname} · ${enums?.occtype?.map?.[String(occupation.occtype)] || occupation.occtype}`
            : "—"}
        </p>
      </Link>

      <div
        onClick={e => e.stopPropagation()}
        onDoubleClick={handleDoubleClick}
        onTouchEnd={handleTouchEnd}
        style={{
          position: "relative", overflow: "hidden",
          borderRadius: "var(--r-lg)",
          cursor: zoomed ? "zoom-out" : "zoom-in",
          maxWidth: "min(88vw, 500px)", maxHeight: "60vh",
        }}
      >
        <img
          ref={imgRef}
          src={getImageUrl(p.profilePicture?.file_url)}
          alt={p.firstname}
          style={{
            display: "block",
            maxWidth: "min(88vw, 500px)", maxHeight: "60vh",
            objectFit: "contain",
            borderRadius: "var(--r-lg)",
            transition: "transform 0.28s ease",
            transform: zoomed ? "scale(2.4)" : "scale(1)",
            transformOrigin: zoomed ? `${zoomPos.x}% ${zoomPos.y}%` : "center center",
            userSelect: "none",
          }}
          draggable={false}
        />
        {zoomed && (
          <div style={{
            position: "absolute", bottom: "10px", left: "50%", transform: "translateX(-50%)",
            background: "rgba(0,0,0,0.55)", color: "#fff", fontSize: "11px",
            padding: "3px 10px", borderRadius: "99px", pointerEvents: "none", whiteSpace: "nowrap",
          }}>
            Double-tap to zoom out
          </div>
        )}
      </div>

      {!zoomed && (
        <p style={{ marginTop: "10px", fontSize: "11px", color: "rgba(255,255,255,0.28)", textAlign: "center" }}>
          Double-tap to zoom · ← → to navigate · ESC to close
        </p>
      )}

      <button
        onClick={(e) => { e.stopPropagation(); onNavigate(index - 1); setZoomed(false); }}
        disabled={index === 0}
        style={{
          position: "absolute", left: "16px", top: "50%", transform: "translateY(-50%)",
          background: "rgba(255,255,255,0.12)", border: "none", borderRadius: "50%",
          width: "44px", height: "44px", fontSize: "20px", color: "#fff",
          cursor: "pointer", opacity: index === 0 ? 0.3 : 1,
          display: "flex", alignItems: "center", justifyContent: "center",
          zIndex: 10,
        }}
      >←</button>

      <button
        onClick={(e) => { e.stopPropagation(); onNavigate(index + 1); setZoomed(false); }}
        disabled={index === profiles.length - 1}
        style={{
          position: "absolute", right: "16px", top: "50%", transform: "translateY(-50%)",
          background: "rgba(255,255,255,0.12)", border: "none", borderRadius: "50%",
          width: "44px", height: "44px", fontSize: "20px", color: "#fff",
          cursor: "pointer", opacity: index === profiles.length - 1 ? 0.3 : 1,
          display: "flex", alignItems: "center", justifyContent: "center",
          zIndex: 10,
        }}
      >→</button>

      <div style={{
        position: "absolute", bottom: "16px", left: "50%", transform: "translateX(-50%)",
        fontSize: "13px", fontWeight: 600, color: "rgba(255,255,255,0.5)",
      }}
        onClick={e => e.stopPropagation()}
      >
        {index + 1} / {profiles.length}
      </div>
    </div>
  );
}
// ─────────────────────────────────────────────────────────────────────────────

// ─── Shareable Card Export Layout ─────────────────────────────────────────────
function ShareCardLayout({ profile, enums, gothras, currentAddress, educationMap }) {
  if (!profile) return null;

  const age        = calcAge(profile.birthdate);
  const heightStr  = formatHeight(profile.height);
  const gothraName = gothras.find(g => String(g.id) === String(profile.swagothra))?.gothraname
                     || profile.swagothranm?.gothraname
                     || null;
  const photoUrl = profile.profilePicture?.file_url
    ? getImageUrl(profile.profilePicture.file_url)
    : null;

  const birthStar = enums?.birthstar?.map?.[profile.birthstar] || null;
  const pada      = enums?.birthpada?.map?.[profile.starpada]  || null;
  const rashi     = enums?.birthrasi?.map?.[profile.birthrasi] || null;
  const padaLabel = pada ? `${pada} ` : null;
  const starStr   = [birthStar, padaLabel].filter(Boolean).join(" · ");

  const eduRows = educationMap?.[profile.id] || [];
  const eduStr  = eduRows.length > 0
    ? eduRows.map(e => e.degree).filter(Boolean).join(", ")
    : [profile.education1, profile.education2].filter(Boolean).join(", ");
  const cityCountry = [currentAddress?.city, currentAddress?.country].filter(Boolean).join(", ");
  const occupation = profile.occupations?.[0];

  const details = [
    { label: "Birth Star / Pada",  value: starStr    },
    { label: "Rashi",       value: rashi      },
    { label: "Swagothram",  value: gothraName },
    { label: "Education",   value: eduStr || null },
    { label: "Occupation", value: occupation?.occname || null },
    { label: "Working Status", value: occupation?.occtype ? enums?.occtype?.map?.[String(occupation.occtype)] : null},
  ].filter(d => d.value);

  return (
    <div style={{ width: 360, height: 640, position: "relative", overflow: "hidden", fontFamily: "Arial, Helvetica, sans-serif", background: "#1a0f00", boxSizing: "border-box", color: "#ffffff" }}>
      {photoUrl ? (
        <img src={photoUrl} alt="" crossOrigin="anonymous" referrerPolicy="no-referrer"
          style={{ position: "absolute", top: 0, left: 0, width: "100%", height: "100%", objectFit: "cover", objectPosition: "center top" }}
        />
      ) : (
        <div style={{ position: "absolute", top: 0, left: 0, width: "100%", height: "100%", background: "linear-gradient(160deg, #3d1f00, #1a0f00)", display: "flex", alignItems: "center", justifyContent: "center" }}>
          <div style={{ width: 90, height: 90, borderRadius: "50%", background: "#b86a0a", display: "flex", alignItems: "center", justifyContent: "center", fontSize: 36, fontWeight: 700, color: "#fff" }}>
            {(profile.firstname || "?")[0]}
          </div>
        </div>
      )}
      <div style={{ position: "absolute", top: 0, left: 0, width: "100%", height: 110, background: "linear-gradient(to bottom, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0.4) 60%, transparent 100%)" }} />
      <div style={{ position: "absolute", bottom: 0, left: 0, width: "100%", height: 340, background: "linear-gradient(to top, rgba(6,2,0,0.98) 0%, rgba(6,2,0,0.85) 50%, transparent 100%)" }} />
      <div style={{ position: "absolute", top: 16, left: 16, right: 16, display: "flex", justifyContent: "space-between", alignItems: "flex-start", gap: 12 }}>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: 11, fontWeight: 700, color: "#fff", lineHeight: 1.3, textShadow: "0 2px 4px rgba(0,0,0,0.8)", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{COMPANY.name}</div>
          <div style={{ fontSize: 8, color: "rgba(255,255,255,0.9)", marginTop: 3, lineHeight: 1.3, textShadow: "0 1px 3px rgba(0,0,0,0.8)", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{COMPANY.subtitle}</div>
        </div>
        <div style={{ background: "#b86a0a", borderRadius: 4, padding: "4px 8px", fontSize: 9, fontWeight: 700, color: "#fff", whiteSpace: "nowrap", boxShadow: "0 2px 6px rgba(0,0,0,0.4)", flexShrink: 0 }}>#{profile.client_id}</div>
      </div>
      <div style={{ position: "absolute", bottom: 0, left: 0, right: 0, padding: "0 16px 16px" }}>
        <div style={{ marginBottom: 12 }}>
          <div style={{ fontSize: 22, fontWeight: 700, color: "#fff", lineHeight: 1.2, marginBottom: 4, textShadow: "0 2px 6px rgba(0,0,0,0.7)", wordBreak: "break-word" }}>{profile.firstname} {profile.lastname}</div>
          <div style={{ fontSize: 11, color: "rgba(255,255,255,0.95)", display: "flex", flexWrap: "wrap", gap: "2px 8px", textShadow: "0 1px 3px rgba(0,0,0,0.5)" }}>
            {profile.birthdate && (
              <span>
                {new Date(profile.birthdate).toLocaleDateString("en-IN", { day: "numeric", month: "long", year: "numeric" })}
                {age ? ` (${age} yrs)` : ""}
              </span>
            )}
            {heightStr && <span>· {heightStr}</span>}
            {cityCountry && <span>· {cityCountry}</span>}
          </div>
        </div>
        <div style={{ height: 1, background: "rgba(184,106,10,0.7)", marginBottom: 12 }} />
        <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "6px 16px", marginBottom: 12 }}>
          {details.map(({ label, value }) => (
            <div key={label} style={{ minWidth: 0 }}>
              <div style={{ fontSize: 7, fontWeight: 700, textTransform: "uppercase", letterSpacing: "0.6px", color: "#e8952a", marginBottom: 3 }}>{label}</div>
              <div style={{ fontSize: 10, fontWeight: 500, color: "#fff", lineHeight: 1.4, wordBreak: "break-word", textShadow: "0 1px 2px rgba(0,0,0,0.4)" }}>{value || "—"}</div>
            </div>
          ))}
        </div>
        <div style={{ borderTop: "1px solid rgba(184,106,10,0.5)", paddingTop: 8 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 4 }}>
            <span style={{ fontSize: 8, fontWeight: 700, color: "#e8952a", letterSpacing: "0.6px", textTransform: "uppercase" }}>{COMPANY.cta}</span>
            <span style={{ fontSize: 7, color: "rgba(255,255,255,0.6)" }}>{COMPANY.city}</span>
          </div>
          <div style={{ fontSize: 8, color: "rgba(255,255,255,0.55)", display: "flex", gap: "10px" }}>
            <span>Venkatesh Babu (s/o Arjunaiah)</span>
            <span>·</span>
            <span>Mob: 9844085118, 9008484741</span>
          </div>
        </div>
      </div>
    </div>
  );
}

// ─── Hook: export a single profile tile as shareable image ────────────────────
function useShareExport() {
  const [exporting,   setExporting]   = useState(false);
  const [exportingId, setExportingId] = useState(null);

  const waitForImages = (element) => {
    const images = Array.from(element.querySelectorAll("img"));
    return Promise.all(
      images.map(img => new Promise((resolve) => {
        if (img.complete && img.naturalWidth > 0) { resolve(); return; }
        const timeout = setTimeout(resolve, 3000);
        const onDone = () => { clearTimeout(timeout); img.removeEventListener("load", onDone); img.removeEventListener("error", onDone); resolve(); };
        img.addEventListener("load", onDone);
        img.addEventListener("error", onDone);
      }))
    );
  };

  const exportCard = useCallback(async (profile, enums, gothras, educationMap) => {
    if (!profile) return;
    setExporting(true);
    setExportingId(profile.client_id);

    const addrs = await getAddresses("profile", profile.id);
    const currentAddress = addrs?.current || null;

    const photoUrl = profile.profilePicture?.file_url
      ? getImageUrl(profile.profilePicture.file_url)
      : null;

    if (photoUrl) {
      const preloadImg = new Image();
      preloadImg.crossOrigin = "anonymous";
      preloadImg.src = photoUrl;
      await new Promise((resolve) => { preloadImg.onload = resolve; preloadImg.onerror = resolve; setTimeout(resolve, 2000); });
    }

    const wrapper = document.createElement("div");
    wrapper.style.cssText = "position:fixed;left:0;top:0;width:0;height:0;overflow:hidden;z-index:-1;";
    document.body.appendChild(wrapper);

    const container = document.createElement("div");
    container.style.cssText = "position:absolute;left:0;top:0;width:360px;height:640px;background:#1a0f00;pointer-events:none;overflow:hidden;";
    wrapper.appendChild(container);

    const root = createRoot(container);
    root.render(
     <ShareCardLayout profile={profile} enums={enums} gothras={gothras} currentAddress={currentAddress} educationMap={educationMap} />
    );

    await new Promise((resolve) => requestAnimationFrame(resolve));
    await waitForImages(container);
    await new Promise((resolve) => setTimeout(resolve, 200));
    const overlay = document.createElement("div");
    overlay.style.cssText = "position:fixed;inset:0;background:#000;opacity:0.01;z-index:99998;pointer-events:none;";
    document.body.appendChild(overlay);
    container.style.left = "0px";
    await new Promise((resolve) => requestAnimationFrame(resolve));

    try {
      const dataUrl = await toJpeg(container, {
        width: 360, height: 640, pixelRatio: 3, backgroundColor: "#1e1101", quality: 0.95,
        skipFonts: true,
        style: { transform: "scale(1)", transformOrigin: "top left" },
        fetchRequestInit: { mode: "cors" },
        filter: (node) => {
          if (node.tagName === "IMG" && (!node.src || node.naturalWidth === 0)) return false;
          return true;
        },
      });
      const link = document.createElement("a");
      link.href = dataUrl;
      link.download = `${profile.firstname}_${profile.lastname}_${profile.client_id ?? "-"}.jpg`;
      link.click();
    } catch (err) {
      console.error("Share export failed:", err);
      alert("Export failed. Please try again.");
    } finally {
      root.unmount();
      try { document.body.removeChild(wrapper); } catch (_) {}
      setExporting(false);
      setExportingId(null);
    }
  }, []);

  return { exportCard, exporting, exportingId };
}

// ═════════════════════════════════════════════════════════════════════════════
export default function ProfilesSearch() {
  const { isAdmin } = useAuth();
  const navigate    = useNavigate();
  const location    = useLocation();
  const admin       = isAdmin();

  const [filters, setFilters] = useState({
    id: "", name: "", birthdateFrom: "", birthdateTo: "", gender: "", client_id: "",
    birthstar: [], status: 1,
    city: "", state: "", district: "",
    minHeight: "", maxHeight: "", phonenumber: "",
    color: "", sortBy: "firstname", sortDir: "asc",
    occtype: [], otherProfession: "", swagothra: "", income: "", networth: "", birthyear: [], country: [],
  });

  const [profiles,       setProfiles]       = useState([]);
  const [educationMap,   setEducationMap]   = useState({});
  const [enums,          setEnums]          = useState(null);
  const [gothras,        setGothras]        = useState([]);
  const [dbCountries,    setDbCountries]    = useState([]);
  const [open,           setOpen]           = useState(false);
  const [openOcc,        setOpenOcc]        = useState(false);
  const [openYear,       setOpenYear]       = useState(false);
  const [historyProfile, setHistoryProfile] = useState(null);
  const [page,           setPage]           = useState(1);
  const [total,          setTotal]          = useState(0);
  const [pages,          setPages]          = useState(1);
  const [openAction,     setOpenAction]     = useState(null);
  const [popoverPos,     setPopoverPos]     = useState({ top: 0, left: 0 });
  const [subFilter,      setSubFilter]      = useState("");
  const [payFilter,      setPayFilter]      = useState("");
  const [viewMode,       setViewMode]       = useState("tile");
  const [previewIndex,   setPreviewIndex]   = useState(null);
  const [countryOpen,    setCountryOpen]    = useState(false);
  const [gothraDropOpen, setGothraDropOpen] = useState(false);
  const [gothraQuery,    setGothraQuery]    = useState("");

  const { exportCard, exporting, exportingId } = useShareExport();

  const currentYear = new Date().getFullYear();
  const birthYears  = Array.from({ length: currentYear - 1970 + 1 }, (_, i) => currentYear - i);

  const load = async (pg = 1) => {
    try {
      const adminFilters = admin
        ? { ...filters, ...(subFilter && { subscriptionName: subFilter }), ...(payFilter && { paymentStatus: payFilter }) }
        : filters;
      const data = admin
        ? await searchProfilesAdmin(adminFilters, pg)
        : await searchProfiles(filters, false, pg);
      const list = Array.isArray(data) ? data : (data?.data || []);
      setProfiles(list);
      setTotal(data?.total ?? list.length);
      setPages(data?.pages ?? 1);
      setPage(pg);

      // ── Fetch education for all profiles in parallel ──
      const eduEntries = await Promise.all(
        list.map(async (p) => {
          const rows = await getEducation(p.id);
          return [p.id, Array.isArray(rows) ? rows : []];
        })
      );
      setEducationMap(Object.fromEntries(eduEntries));

    } catch (err) {
      console.error("Error loading profiles:", err);
      setProfiles([]);
    }
  };

  // ── Fetch gothras, enums, and countries on mount ──
  useEffect(() => {
    getGothras().then(data => {
      const sorted = (data || []).sort((a, b) => {
        const nameA = a.aliases?.[0] || a.gothraname;
        const nameB = b.aliases?.[0] || b.gothraname;
        return nameA.localeCompare(nameB);
      });
      setGothras(sorted);
    });

    getCountries()
      .then((list) => setDbCountries(Array.isArray(list) ? list : []))
      .catch(() => {});

    loadFormEnums("profile").then(async (e) => {
      setEnums(e);
      load(1);
    });
  }, [location]);

  useEffect(() => {
    const handler = () => {
      setOpen(false);
      setOpenOcc(false);
      setOpenYear(false);
      setOpenAction(null);
      setCountryOpen(false);
      setGothraDropOpen(false);
    };
    document.addEventListener("click", handler);
    return () => document.removeEventListener("click", handler);
  }, []);

  const onChange        = (e) => setFilters({ ...filters, [e.target.name]: e.target.value });
  const handleSubFilter = (e) => { setSubFilter(e.target.value); setPage(1); };
  const handlePayFilter = (e) => { setPayFilter(e.target.value); setPage(1); };

  const toggleBirthStar = (value) => {
    setFilters(prev => ({
      ...prev,
      birthstar: prev.birthstar.includes(value)
        ? prev.birthstar.filter(v => v !== value)
        : [...prev.birthstar, value],
    }));
  };

  const toggleOccType = (value) => {
    setFilters(prev => ({
      ...prev,
      occtype: prev.occtype.includes(value)
        ? prev.occtype.filter(v => v !== value)
        : [...prev.occtype, value],
    }));
  };

  const toggleBirthYear = (year) => {
    setFilters(prev => ({
      ...prev,
      birthyear: prev.birthyear.includes(year)
        ? prev.birthyear.filter(y => y !== year)
        : [...prev.birthyear, year],
    }));
  };

  const handleConfirmPayment = async (profileId) => {
    if (!window.confirm("Confirm payment received?")) return;
    try {
      const res = await confirmPayment(profileId);
      if (res.success) {
        setProfiles(prev => prev.map(p =>
          p.id === profileId
            ? { ...p, latestPlan: { ...(p.latestPlan || {}), payment_status: res.payment_status, payment_confirmed_at: res.payment_confirmed_at } }
            : p
        ));
      } else alert("Failed to confirm payment");
    } catch { alert("Failed to confirm payment"); }
  };

  if (!enums) return null;

  const subLabel = { bronze: "Bronze", silver: "Silver", gold: "Gold", diamond: "Diamond" };

  // ─── Tile card ──────────────────────────────────────────────────────────────
  const renderTileCard = (p, i) => {
    const age        = calcAge(p.birthdate);
    const gothraName = gothras.find(g => String(g.id) === String(p.swagothra))?.gothraname
                       || p.swagothranm?.gothraname
                       || null;
    const plan       = p.latestPlan;

    return (
      <div
        key={p.id}
        style={{
          background: "var(--surface)",
          border: "1px solid var(--border)",
          borderRadius: "var(--r-md)",
          overflow: "hidden",
          display: "flex",
          flexDirection: "column",
        }}
      >
        {/* Photo hero */}
        <div
          style={{
            position: "relative", width: "100%", aspectRatio: "3/4",
            background: "var(--bg)", overflow: "hidden", cursor: "pointer",
          }}
          onClick={() => setPreviewIndex(i)}
        >
          <img
            src={getImageUrl(p.profilePicture?.file_url)}
            alt={p.firstname}
            style={{ width: "100%", height: "100%", objectFit: "contain", display: "block" }}
          />
          {/* Status dot */}
          <span style={{
            position: "absolute", top: "10px", right: "10px",
            width: "10px", height: "10px", borderRadius: "50%",
            border: "2px solid #fff",
            background: (p.profilests === 1 || p.profilests === "1") ? "#0dd532" : "#f90505",
          }} />
          {/* Overlay */}
          <div style={{
            position: "absolute", bottom: 0, left: 0, right: 0,
            padding: "28px 12px 12px",
            background: "linear-gradient(to top, rgba(0,0,0,0.68) 0%, transparent 100%)",
          }}>
            <p style={{ margin: "0 0 3px", fontSize: "14px", fontWeight: 600, color: "#fff", lineHeight: 1.2 }}>
              {p.firstname} {p.lastname}
              <span style={{ fontSize: "11px", fontWeight: 500, opacity: 0.7, marginLeft: "6px" }}>#{p.client_id}</span>
            </p>
            <p style={{ margin: "0 0 2px", fontSize: "11px", color: "rgba(255,255,255,0.82)", lineHeight: 1.3 }}>
              {p.birthdate
                ? `${new Date(p.birthdate).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" })}${age ? ` (${age} yrs)` : ""}`
                : "—"}
              {p.height ? ` · ${formatHeight(p.height)}` : ""}
            </p>
            <p style={{ margin: 0, fontSize: "10px", color: "rgba(255,255,255,0.55)" }}>
              {gothraName || "—"}
            </p>
            <p style={{ margin: "0 0 2px", fontSize: "10px", color: "rgba(255,255,255,0.65)", lineHeight: 1.3 }}>
              {[
                enums?.birthstar?.map?.[p.birthstar],
                enums?.birthrasi?.map?.[p.birthrasi]
              ].filter(Boolean).join(" · ") || "—"}
            </p>
            <p style={{ margin: "0 0 2px", fontSize: "11px", color: "rgba(255,255,255,0.82)", lineHeight: 1.3 }}>
              {(educationMap[p.id]?.length > 0)
                ? educationMap[p.id].map(e => e.degree).filter(Boolean).join(" · ")
                : "—"}
            </p>
            <p style={{ margin: "0 0 2px", fontSize: "11px", color: "rgba(255,255,255,0.82)", lineHeight: 1.3 }}>
              Working Status: {
                p.occupations?.[0]
                  ? `${p.occupations[0].occname} (${enums?.occtype?.map?.[String(p.occupations[0].occtype)] || p.occupations[0].occtype})`
                  : "—"
              }
              </p>
          </div>
        </div>

        {/* Below-photo details */}
        <div style={{ padding: "10px 12px 8px", flex: 1, display: "flex", flexDirection: "column", gap: "6px" }}>
          {/* Badges */}
          <div style={{ display: "flex", gap: "5px", flexWrap: "wrap" }}>
            {admin && (
              <span className={`badge ${p.profilests === 1 ? "badge-teal" : "badge-neutral"}`}>
                {p.profilests === 1 ? "Active" : "Inactive"}
              </span>
            )}
            {plan?.subscription_name && (
              <span className="badge badge-neutral">{subLabel[plan.subscription_name] || plan.subscription_name}</span>
            )}
            {plan && (
              <PaymentBadge status={plan.payment_status || "unpaid"} expiryDate={plan.plan_expiry} />
            )}
          </div>

          {/* Detail grid */}
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "5px 12px" }}>
            {[
              ["Income",   p.income   || "—"],
              ["Networth", p.networth || "—"],
              ...(admin ? [
                ["Registered",  p.createdon       ? new Date(p.createdon).toLocaleDateString("en-IN",         { day: "2-digit", month: "2-digit", year: "numeric" }) : "N/A"],
                ["Plan Expiry", plan?.plan_expiry  ? new Date(plan.plan_expiry).toLocaleDateString("en-IN",   { day: "2-digit", month: "2-digit", year: "numeric" }) : "—"],
                ["Last Active", p.last_interaction ? new Date(p.last_interaction).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" }) : "Never"],
              ] : []),
            ].map(([label, value]) => (
              <div key={label}>
                <p style={{ margin: "0 0 1px", fontSize: "9px", color: "var(--ink-3)", textTransform: "uppercase", letterSpacing: "0.04em" }}>{label}</p>
                <p style={{ margin: 0, fontSize: "12px", color: "var(--ink)" }}>{value}</p>
              </div>
            ))}
            {/* Matches */}
            <div>
              <p style={{ margin: "0 0 1px", fontSize: "9px", color: "var(--ink-3)", textTransform: "uppercase", letterSpacing: "0.04em" }}>Matches</p>
              <button className="ps-match-pill"
                onClick={() => navigate(`/profiles/${p.id}/match`, { state: { fromProfile: location.pathname } })}>
                {p.matchcount || 0}
              </button>
            </div>
          </div>

          {/* Action buttons */}
          <div style={{ display: "flex", gap: "5px", marginTop: "4px", paddingTop: "8px", borderTop: "1px solid var(--border)", flexWrap: "wrap" }}>
            <Link to={`/profiles/${p.id}`} className="ps-action-btn" target="_blank" style={{ fontSize: "11px", padding: "4px 10px" }}>View</Link>
            <Link to={`/profiles/${p.id}/edit`} className="ps-action-btn" target="_blank" style={{ fontSize: "11px", padding: "4px 10px" }}>Edit</Link>
            {p.profilests === 1 ? (
              <button className="ps-action-btn" style={{ fontSize: "11px", padding: "4px 10px" }}
                onClick={async () => {
                  const reason = window.prompt("Enter reason for inactivating this profile:");
                  if (reason !== null) { await changests(p.id, 2, reason); load(page); }
                }}>
                Inactivate
              </button>
            ) : (
              <button className="ps-action-btn" style={{ fontSize: "11px", padding: "4px 10px" }}
                onClick={async () => { if (window.confirm("Activate this profile?")) { await changests(p.id, 1); load(page); } }}>
                Activate
              </button>
            )}
            {admin && (
              <button className="ps-action-btn" style={{ fontSize: "11px", padding: "4px 10px" }}
                onClick={() => setHistoryProfile(p)}>
                Plans
              </button>
            )}
            {admin && plan?.payment_status === "unpaid" && (
              <button className="ps-action-btn" style={{ fontSize: "11px", padding: "4px 10px", background: "var(--teal, #2ecc71)", color: "#fff", border: "none" }}
                onClick={() => handleConfirmPayment(p.id)}>
                Confirm Pay
              </button>
            )}
            <button
              className="ps-action-btn"
              style={{ fontSize: "11px", padding: "4px 10px", opacity: exportingId === p.client_id ? 0.6 : 1 }}
              disabled={exporting}
              onClick={() => exportCard(p, enums, gothras, educationMap)}
              title="Export share card"
            >
              {exportingId === p.client_id ? "…" : "Share"}
            </button>
          </div>
        </div>
      </div>
    );
  };
  // ───────────────────────────────────────────────────────────────────────────

  return (
    <div className="ps-page">

      {historyProfile && (
        <PlanHistoryModal profile={historyProfile} onClose={() => setHistoryProfile(null)} />
      )}

      {previewIndex !== null && (
        <PhotoModal
          profiles={profiles}
          index={previewIndex}
          onClose={() => setPreviewIndex(null)}
          onNavigate={(idx) => { if (idx >= 0 && idx < profiles.length) setPreviewIndex(idx); }}
          gothras={gothras}
          enums={enums}
          educationMap={educationMap}
        />
      )}

      {/* Actions Popover */}
      {openAction !== null && (() => {
        const p = profiles.find(x => x.id === openAction);
        if (!p) return null;
        const plan = p.latestPlan;
        return (
          <div onClick={e => e.stopPropagation()}
            style={{ position: "absolute", top: popoverPos.top, left: popoverPos.left, zIndex: 1000, background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", boxShadow: "0 4px 16px rgba(0,0,0,0.15)", padding: "6px", display: "flex", flexDirection: "column", gap: "4px", minWidth: "150px" }}
          >
            <Link to={`/profiles/${p.id}`} target="_blank" rel="noopener noreferrer" className="ps-action-btn" style={{ display: "block", textAlign: "left" }} onClick={() => setOpenAction(null)}>View</Link>
            <Link to={`/profiles/${p.id}/edit`} className="ps-action-btn" style={{ display: "block", textAlign: "left" }} onClick={() => setOpenAction(null)}>Edit</Link>
            {p.profilests === 1 ? (
              <button className="ps-action-btn" style={{ textAlign: "left", width: "100%" }}
                onClick={async () => { if (window.confirm("Inactivate this profile?")) { await changests(p.id, 2); setOpenAction(null); load(page); } }}>
                Inactivate
              </button>
            ) : (
              <button className="ps-action-btn" style={{ textAlign: "left", width: "100%" }}
                onClick={async () => { if (window.confirm("Activate this profile?")) { await changests(p.id, 1); setOpenAction(null); load(page); } }}>
                Activate
              </button>
            )}
            {admin && <>
            <button className="ps-action-btn" style={{ textAlign: "left", width: "100%" }} onClick={() => { setHistoryProfile(p); setOpenAction(null); }}>Plans History</button>
            {plan?.payment_status === "unpaid" && (
              <button className="ps-action-btn" style={{ textAlign: "left", width: "100%", background: "var(--teal, #2ecc71)", color: "#fff", border: "none" }}
                onClick={() => { handleConfirmPayment(p.id); setOpenAction(null); }}>
                Confirm Payment
              </button>
            )}
          </>}
          <button
            className="ps-action-btn"
            style={{ textAlign: "left", width: "100%", opacity: exportingId === p.client_id ? 0.6 : 1 }}
            disabled={exporting}
            onClick={() => { exportCard(p, enums, gothras, educationMap); setOpenAction(null); }}
            title="Export share card"
          >
            {exportingId === p.client_id ? "Exporting…" : "Share"}
          </button>
          </div>
        );
      })()}

      {/* ── Header ── */}
      <div className="ps-header">
        <div>
          <p className="ps-header-eyebrow">Directory</p>
          <h1 className="ps-header-title">Profiles</h1>
          <div className="ps-header-bar" />
        </div>
        <Link to="/profiles/new" className="ps-add-btn">
          <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
            <path d="M7 1v12M1 7h12" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
          </svg>
          Add Profile
        </Link>
      </div>

      {/* ── Filters ── */}
      <div className="ps-filter-card">
        <div className="ps-filter-title">
          <svg width="13" height="13" viewBox="0 0 14 14" fill="none">
            <path d="M1 2h12l-4.5 5.5V12L5.5 13V7.5L1 2z" stroke="currentColor" strokeWidth="1.5" strokeLinejoin="round"/>
          </svg>
          Search Filters
        </div>
        <div className="ps-filter-grid">

          <div className="ps-field">
            <label className="ps-label">ClientID</label>
            <input className="ps-input" name="client_id" placeholder="e.g. 19123" value={filters.client_id} onChange={onChange} />
          </div>

          <div className="ps-field">
            <label className="ps-label">Phone Number</label>
            <input className="ps-input" name="phonenumber" placeholder="e.g. 9876543210" value={filters.phonenumber} onChange={onChange} />
          </div>

          {/* Birth Year multi-select */}
          <div className="ps-field">
            <label className="ps-label">Birth Year</label>
            <div style={{ position: "relative" }}>
              <button type="button" className="ps-input ps-select"
                onClick={(e) => { e.stopPropagation(); setOpenYear(!openYear); }}
                style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}
              >
                <span style={{ color: filters.birthyear.length > 0 ? "var(--ink)" : "var(--ink-4)" }}>
                  {filters.birthyear.length > 0
                    ? `${filters.birthyear.length} year${filters.birthyear.length > 1 ? "s" : ""} selected`
                    : "Select Birth Years"}
                </span>
                {filters.birthyear.length > 0 && (
                  <span onClick={(e) => { e.stopPropagation(); setFilters(prev => ({ ...prev, birthyear: [] })); }}
                    style={{ fontSize: "11px", color: "var(--ink-3)", marginLeft: "6px", cursor: "pointer" }}>✕</span>
                )}
              </button>
              {filters.birthyear.length > 0 && (
                <div style={{ marginTop: "4px", fontSize: "11px", color: "var(--ink-3)", lineHeight: 1.6 }}>
                  {filters.birthyear.join(" · ")}
                </div>
              )}
              {openYear && (
                <div style={{ position: "absolute", zIndex: 10, top: "100%", left: 0, right: 0, background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", boxShadow: "0 4px 16px rgba(0,0,0,0.12)", maxHeight: "200px", overflowY: "auto", marginTop: "4px" }}>
                  {birthYears.map(year => (
                    <label key={year} onClick={e => e.stopPropagation()}
                      style={{ display: "flex", alignItems: "center", gap: "8px", padding: "6px 10px", cursor: "pointer", fontSize: "13px" }}
                      onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                      onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                    >
                      <input type="checkbox" style={{ width: "13px", height: "13px", accentColor: "var(--amber)" }}
                        checked={filters.birthyear.includes(year)} onChange={() => toggleBirthYear(year)} />
                      {year}
                    </label>
                  ))}
                </div>
              )}
            </div>
          </div>

          {/* Birthstar multi-select */}
          <div className="ps-field">
            <label className="ps-label">Birthstar</label>
            <div style={{ position: "relative" }}>
              <button type="button" className="ps-input ps-select"
                onClick={(e) => { e.stopPropagation(); setOpen(!open); }}
                style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}
              >
                <span style={{ color: filters.birthstar.length > 0 ? "var(--ink)" : "var(--ink-4)" }}>
                  {filters.birthstar.length > 0 ? `${filters.birthstar.length} star${filters.birthstar.length > 1 ? "s" : ""} selected` : "Select Birth Stars"}
                </span>
                {filters.birthstar.length > 0 && (
                  <span onClick={(e) => { e.stopPropagation(); setFilters(prev => ({ ...prev, birthstar: [] })); }}
                    style={{ fontSize: "11px", color: "var(--ink-3)", marginLeft: "6px", cursor: "pointer" }}>✕</span>
                )}
              </button>
              {filters.birthstar.length > 0 && (
                <div style={{ marginTop: "4px", fontSize: "11px", color: "var(--ink-3)", lineHeight: 1.6 }}>
                  {filters.birthstar.map(v => enums.birthstar.options.find(o => o.enumvalue === v)?.strvalue).filter(Boolean).join(" · ")}
                </div>
              )}
              {open && (
                <div style={{ position: "absolute", zIndex: 10, top: "100%", left: 0, right: 0, background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", boxShadow: "0 4px 16px rgba(0,0,0,0.12)", maxHeight: "200px", overflowY: "auto", marginTop: "4px" }}>
                  {enums.birthstar.options.map(o => (
                    <label key={o.enumvalue} onClick={e => e.stopPropagation()}
                      style={{ display: "flex", alignItems: "center", gap: "8px", padding: "6px 10px", cursor: "pointer", fontSize: "13px" }}
                      onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                      onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                    >
                      <input type="checkbox" style={{ width: "13px", height: "13px", accentColor: "var(--amber)" }}
                        checked={filters.birthstar.includes(o.enumvalue)} onChange={() => toggleBirthStar(o.enumvalue)} />
                      {o.strvalue}
                    </label>
                  ))}
                </div>
              )}
            </div>
          </div>

          <div className="ps-field">
            <label className="ps-label">City</label>
            <input className="ps-input" name="city" placeholder="City or town" value={filters.city} onChange={onChange} />
          </div>

          <div className="ps-field">
            <label className="ps-label">State</label>
            <input className="ps-input" name="state" placeholder="State or province" value={filters.state} onChange={onChange} />
          </div>

          {/* Country multi-select */}
          <div className="ps-field">
            <label className="ps-label">Country</label>
            <div style={{ position: "relative" }}>
              <button type="button" className="ps-input ps-select"
                onClick={(e) => { e.stopPropagation(); setCountryOpen(!countryOpen); }}
                style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}
              >
                <span style={{ color: filters.country.length > 0 ? "var(--ink)" : "var(--ink-4)" }}>
                  {filters.country.length > 0 ? `${filters.country.length} selected` : "All Countries"}
                </span>
                {filters.country.length > 0 && (
                  <span onClick={(e) => { e.stopPropagation(); setFilters(prev => ({ ...prev, country: [] })); }}
                    style={{ fontSize: "11px", color: "var(--ink-3)", marginLeft: "6px", cursor: "pointer" }}>✕</span>
                )}
              </button>
              {filters.country.length > 0 && (
                <div style={{ marginTop: "4px", fontSize: "11px", color: "var(--ink-3)", lineHeight: 1.6 }}>
                  {filters.country.join(" · ")}
                </div>
              )}
              {countryOpen && (
                <div style={{ position: "absolute", zIndex: 10, top: "100%", left: 0, right: 0, background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", boxShadow: "0 4px 16px rgba(0,0,0,0.12)", maxHeight: "200px", overflowY: "auto", marginTop: "4px" }}>
                  <label onClick={e => e.stopPropagation()}
                    style={{ display: "flex", alignItems: "center", gap: "8px", padding: "6px 10px", cursor: "pointer", fontSize: "13px", borderBottom: "1px solid var(--border)" }}
                    onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                    onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                  >
                    <input type="checkbox" style={{ width: "13px", height: "13px", accentColor: "var(--amber)" }}
                      checked={filters.country.includes("all")}
                      onChange={() => setFilters(prev => {
                        const hasAbroad = prev.country.includes("all");
                        return {
                          ...prev,
                          country: hasAbroad ? prev.country.filter(c => c !== "all") : ["all"],
                        };
                      })} />
                    Abroad
                  </label>
                  <label onClick={e => e.stopPropagation()}
                    style={{ display: "flex", alignItems: "center", gap: "8px", padding: "6px 10px", cursor: "pointer", fontSize: "13px", borderBottom: "1px solid var(--border)" }}
                    onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                    onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                  >
                    <input type="checkbox" style={{ width: "13px", height: "13px", accentColor: "var(--amber)" }}
                      checked={filters.country.includes("India")}
                      onChange={() => setFilters(prev => {
                        const without = prev.country.filter(c => c !== "all");
                        return {
                          ...prev,
                          country: without.includes("India") ? without.filter(c => c !== "India") : [...without, "India"],
                        };
                      })} />
                    India
                  </label>                  
                  {dbCountries.filter(c => c !== "India").sort((a, b) => a.localeCompare(b)).map(c => (
                    <label key={c} onClick={e => e.stopPropagation()}
                      style={{ display: "flex", alignItems: "center", gap: "8px", padding: "6px 10px", cursor: "pointer", fontSize: "13px" }}
                      onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                      onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                    >
                      <input type="checkbox" style={{ width: "13px", height: "13px", accentColor: "var(--amber)" }}
                        checked={filters.country.includes(c)}
                        onChange={() => setFilters(prev => {
                          const without = prev.country.filter(x => x !== "all");
                          return {
                            ...prev,
                            country: without.includes(c) ? without.filter(x => x !== c) : [...without, c],
                          };
                        })} />
                      {c}
                    </label>
                  ))}
                </div>
              )}
            </div>
          </div>

          <div className="ps-field">
            <label className="ps-label">Min Height</label>
            <HeightPicker
              valueCm={filters.minHeight}
              onChange={(cm) => setFilters(prev => ({ ...prev, minHeight: cm }))}
            />
          </div>

          <div className="ps-field">
            <label className="ps-label">Max Height</label>
            <HeightPicker
              valueCm={filters.maxHeight}
              onChange={(cm) => setFilters(prev => ({ ...prev, maxHeight: cm }))}
            />
          </div>

          <div className="ps-field">
            <label className="ps-label">Gender</label>
            <select className="ps-input ps-select" name="gender" value={filters.gender} onChange={onChange}>
              <option value="">All</option>
              <option value="1">Male</option>
              <option value="2">Female</option>
            </select>
          </div>

          <div className="ps-field">
            <label className="ps-label">Status</label>
            <select className="ps-input ps-select" value={filters.status}
              onChange={e => setFilters({ ...filters, status: Number(e.target.value) })}>
              <option value={0}>All</option>
              <option value={1}>Active</option>
              <option value={2}>Inactive</option>
            </select>
          </div>

          <div className="ps-field">
            <label className="ps-label">Swagothram</label>
            <div style={{ position: "relative" }}>
              <input
                type="text"
                className="ps-input"
                placeholder="Search gothra…"
                value={
                  filters.swagothra
                    ? (() => {
                        const g = gothras.find(x => String(x.id) === String(filters.swagothra));
                        return g ? `${g.gothraname}${g.aliases?.length ? " · " + g.aliases.join(", ") : ""}` : "";
                      })()
                    : gothraQuery
                }
                onChange={e => {
                  setGothraQuery(e.target.value);
                  setGothraDropOpen(true);
                  if (!e.target.value) setFilters(prev => ({ ...prev, swagothra: "" }));
                }}
                onFocus={() => setGothraQuery("")}
                onClick={(e) => { e.stopPropagation(); setGothraDropOpen(true); }}
              />
              {filters.swagothra && (
                <span
                  onClick={() => { setFilters(prev => ({ ...prev, swagothra: "" })); setGothraQuery(""); }}
                  style={{ position: "absolute", right: "10px", top: "50%", transform: "translateY(-50%)", cursor: "pointer", fontSize: "12px", color: "var(--ink-3)" }}
                >✕</span>
              )}

              {gothraDropOpen && (() => {
                const q = gothraQuery.toLowerCase();
                const filtered = gothras.filter(g => {
                  if (!q) return true;
                  if (g.gothraname.toLowerCase().includes(q)) return true;
                  if (g.aliases?.some(a => a.toLowerCase().includes(q))) return true;
                  return false;
                });
                if (filtered.length === 0) return null;
                return (
                  <div
                    onClick={e => e.stopPropagation()}
                    style={{
                      position: "absolute", zIndex: 20, left: 0, right: 0,
                      background: "var(--surface)", border: "1px solid var(--border)",
                      borderRadius: "var(--r-sm)", boxShadow: "0 4px 16px rgba(0,0,0,0.12)",
                      maxHeight: "220px", overflowY: "auto", marginTop: "4px",
                    }}
                  >
                    <div
                      onMouseDown={(e) => { e.preventDefault(); setFilters(prev => ({ ...prev, swagothra: "" })); setGothraQuery(""); setGothraDropOpen(false); }}
                      style={{ padding: "7px 12px", cursor: "pointer", fontSize: "13px", color: "var(--ink-3)", borderBottom: "1px solid var(--border)" }}
                      onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                      onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                    >
                      All Gothras
                    </div>
                    {filtered.map(g => (
                      <div
                        key={g.id}
                        onMouseDown={(e) => { e.preventDefault(); setFilters(prev => ({ ...prev, swagothra: g.id })); setGothraQuery(""); setGothraDropOpen(false); }}
                        style={{ padding: "8px 12px", cursor: "pointer", fontSize: "13px", color: "var(--ink)", background: String(g.id) === String(filters.swagothra) ? "var(--bg)" : "transparent" }}
                        onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                        onMouseLeave={e => e.currentTarget.style.background = String(g.id) === String(filters.swagothra) ? "var(--bg)" : "transparent"}
                      >
                        <span style={{ fontWeight: 500 }}>{g.gothraname}</span>
                        {g.aliases?.length > 0 && (
                          <span style={{ fontSize: "11px", color: "var(--ink-3)", marginLeft: "6px" }}>
                            · {g.aliases.join(", ")}
                          </span>
                        )}
                      </div>
                    ))}
                  </div>
                );
              })()}
            </div>
          </div>

          <div className="ps-field">
            <label className="ps-label">Min Income</label>
            <input className="ps-input" name="income" placeholder="in lakhs" value={filters.income} onChange={onChange} />
          </div>

          <div className="ps-field">
            <label className="ps-label">Min Networth</label>
            <input className="ps-input" name="networth" placeholder="in crores" value={filters.networth} onChange={onChange} />
          </div>

          {/* Occupation multi-select */}
          <div className="ps-field">
            <label className="ps-label">Occupation</label>
            <div style={{ position: "relative" }}>
              <button type="button" className="ps-input ps-select"
                onClick={(e) => { e.stopPropagation(); setOpenOcc(!openOcc); }}
                style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}
              >
                <span style={{ color: filters.occtype.length > 0 ? "var(--ink)" : "var(--ink-4)" }}>
                  {filters.occtype.length > 0 ? `${filters.occtype.length} selected` : "Select Occupation"}
                </span>
                {filters.occtype.length > 0 && (
                  <span onClick={(e) => { e.stopPropagation(); setFilters(prev => ({ ...prev, occtype: [] })); }}
                    style={{ fontSize: "11px", color: "var(--ink-3)", marginLeft: "6px", cursor: "pointer" }}>✕</span>
                )}
              </button>
              {filters.occtype.length > 0 && (
                <div style={{ marginTop: "4px", fontSize: "11px", color: "var(--ink-3)", lineHeight: 1.6 }}>
                  {filters.occtype.map(v => enums.occtype.options.find(o => o.enumvalue === v)?.strvalue).filter(Boolean).join(" · ")}
                </div>
              )}
              {openOcc && (
                <div style={{ position: "absolute", zIndex: 20, top: "100%", left: 0, right: 0, background: "var(--surface)", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", boxShadow: "0 4px 16px rgba(0,0,0,0.12)", maxHeight: "160px", overflowY: "auto", marginTop: "4px" }}>
                  {enums.occtype.options.map(o => (
                    <label key={o.enumvalue} onClick={e => e.stopPropagation()}
                      style={{ display: "flex", alignItems: "center", gap: "8px", padding: "6px 10px", cursor: "pointer", fontSize: "13px" }}
                      onMouseEnter={e => e.currentTarget.style.background = "var(--bg)"}
                      onMouseLeave={e => e.currentTarget.style.background = "transparent"}
                    >
                      <input type="checkbox" style={{ width: "13px", height: "13px", accentColor: "var(--amber)" }}
                        checked={filters.occtype.includes(o.enumvalue)} onChange={() => toggleOccType(o.enumvalue)} />
                      <span>{o.strvalue}</span>
                    </label>
                  ))}
                </div>
              )}
            </div>
          </div>

          {filters.occtype.length > 0 && (
            <div className="ps-field">
              <label className="ps-label">Profession</label>
              <input className="ps-input" name="otherProfession"
                placeholder="Type profession (e.g. Doctor, Engineer)"
                value={filters.otherProfession} onChange={onChange} />
            </div>
          )}

          {admin && <>
            <div className="ps-field">
              <label className="ps-label">Subscription</label>
              <select className="ps-input ps-select" value={subFilter} onChange={handleSubFilter}>
                <option value="">All</option>
                <option value="bronze">Bronze</option>
                <option value="silver">Silver</option>
                <option value="gold">Gold</option>
                <option value="diamond">Diamond</option>
              </select>
            </div>
            <div className="ps-field">
              <label className="ps-label">Payment Status</label>
              <select className="ps-input ps-select" value={payFilter} onChange={handlePayFilter}>
                <option value="">All</option>
                <option value="paid">Paid</option>
                <option value="expiring">Expiring</option>
                <option value="expired">Expired</option>
                <option value="unpaid">Unpaid</option>
              </select>
            </div>
          </>}

        </div>

        <div className="ps-filter-footer">
          <span className="ps-results-count">{profiles.length} of {total} profile{total !== 1 ? "s" : ""} found</span>
          <button className="ps-search-btn" onClick={() => load(1)}>
            Search
            <svg width="13" height="13" viewBox="0 0 14 14" fill="none">
              <circle cx="5.5" cy="5.5" r="4" stroke="currentColor" strokeWidth="1.5"/>
              <path d="M8.5 8.5L12 12" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round"/>
            </svg>
          </button>
        </div>
      </div>

      {/* ── View toggle ── */}
      <div style={{ display: "flex", justifyContent: "flex-end", margin: "12px 0 4px" }}>
        <div style={{ display: "flex", border: "1px solid var(--border)", borderRadius: "var(--r-sm)", overflow: "hidden" }}>
          <button onClick={() => setViewMode("tile")} title="Tile view"
            style={{
              padding: "6px 12px", border: "none", cursor: "pointer",
              background: viewMode === "tile" ? "var(--amber, #f59e0b)" : "var(--surface)",
              color:      viewMode === "tile" ? "#fff" : "var(--ink-3)",
              display: "flex", alignItems: "center", gap: "5px", fontSize: "12px",
              transition: "background 0.15s",
            }}
          >
            <svg width="13" height="13" viewBox="0 0 14 14" fill="none">
              <rect x="1" y="1" width="5" height="5" rx="1" stroke="currentColor" strokeWidth="1.4"/>
              <rect x="8" y="1" width="5" height="5" rx="1" stroke="currentColor" strokeWidth="1.4"/>
              <rect x="1" y="8" width="5" height="5" rx="1" stroke="currentColor" strokeWidth="1.4"/>
              <rect x="8" y="8" width="5" height="5" rx="1" stroke="currentColor" strokeWidth="1.4"/>
            </svg>
            Tile
          </button>
          <button onClick={() => setViewMode("list")} title="List view"
            style={{
              padding: "6px 12px", border: "none", borderLeft: "1px solid var(--border)", cursor: "pointer",
              background: viewMode === "list" ? "var(--amber, #f59e0b)" : "var(--surface)",
              color:      viewMode === "list" ? "#fff" : "var(--ink-3)",
              display: "flex", alignItems: "center", gap: "5px", fontSize: "12px",
              transition: "background 0.15s",
            }}
          >
            <svg width="13" height="13" viewBox="0 0 14 14" fill="none">
              <path d="M1 3h12M1 7h12M1 11h12" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round"/>
            </svg>
            List
          </button>
        </div>
      </div>

      {/* ── Results ── */}
      {profiles.length === 0 ? (
        <div className="ps-empty">
          <div className="ps-empty-icon">
            <svg width="28" height="28" viewBox="0 0 32 32" fill="none">
              <circle cx="14" cy="14" r="9" stroke="currentColor" strokeWidth="2"/>
              <path d="M21 21l6 6" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </div>
          <p className="ps-empty-title">No profiles found</p>
          <p className="ps-empty-sub">Try adjusting your filters or add a new profile</p>
          <Link to="/profiles/new" className="ps-add-btn" style={{ marginTop: 12 }}>Add Profile</Link>
        </div>

      ) : viewMode === "tile" ? (
        <div style={{
          display: "grid",
          gridTemplateColumns: "repeat(5, 1fr)",
          gap: "16px",
        }}>
          {profiles.map((p, i) => renderTileCard(p, i))}
        </div>

      ) : (
        <div className="ps-table-wrap">
          <table className="ps-table">
            <thead>
              <tr>
                <th className="ps-th">Photo</th>
                <th className="ps-th">Name</th>
                <th className="ps-th">Birthdate</th>
                <th className="ps-th">Height</th>
                <th className="ps-th">Matches</th>
                <th className="ps-th">Status</th>
                <th className="ps-th">Income</th>
                <th className="ps-th">Networth</th>
                {admin && <>
                  <th className="ps-th">Registered On</th>
                  <th className="ps-th">Subscription</th>
                  <th className="ps-th">Payment</th>
                  <th className="ps-th">Plan Expiry</th>
                  <th className="ps-th">Last Interaction</th>
                </>}
                <th className="ps-th"></th>
              </tr>
            </thead>
            <tbody>
              {profiles.map((p, i) => {
                const plan = p.latestPlan;
                return (
                  <tr className="ps-tr" key={p.id} style={{ animationDelay: `${i * 0.04}s` }}>
                    <td className="ps-td">
                      <img
                        src={getImageUrl(p.profilePicture?.file_url)}
                        alt={p.firstname} className="ps-table-avatar"
                        style={{ cursor: "pointer" }}
                        onClick={() => setPreviewIndex(i)}
                      />
                    </td>
                    <td className="ps-td">
                      <Link to={`/profiles/${p.id}`} style={{ textDecoration: "none" }}>
                        <p className="ps-table-name" style={{ cursor: "pointer" }}
                          onMouseEnter={e => e.currentTarget.style.color = "var(--amber)"}
                          onMouseLeave={e => e.currentTarget.style.color = ""}>
                          {p.firstname} {p.lastname}
                        </p>
                      </Link>
                      <p className="ps-table-id">#{p.client_id}</p>
                    </td>
                    <td className="ps-td ps-td-meta">
                      {p.birthdate ? new Date(p.birthdate).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" }) : "—"}
                    </td>
                    <td className="ps-td ps-td-meta">{formatHeight(p.height) || "—"}</td>
                    <td className="ps-td">
                      <button className="ps-match-pill"
                        onClick={() => navigate(`/profiles/${p.id}/match`, { state: { fromProfile: location.pathname } })}>
                        {p.matchcount || 0}
                      </button>
                    </td>
                    <td className="ps-td">
                      <span className={`badge ${p.profilests === 1 ? "badge-teal" : "badge-neutral"}`}>
                        {p.profilests === 1 ? "Active" : "Inactive"}
                      </span>
                    </td>
                    <td className="ps-td ps-td-meta">{p.income || "—"}</td>
                    <td className="ps-td ps-td-meta">{p.networth || "—"}</td>
                    {admin && <>
                      <td className="ps-td ps-td-meta">
                        {p.createdon ? new Date(p.createdon).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" }) : "N/A"}
                      </td>
                      <td className="ps-td">
                        {plan?.subscription_name
                          ? <span className="badge badge-neutral">{subLabel[plan.subscription_name] || plan.subscription_name}</span>
                          : <span style={{ color: "var(--ink-3)" }}>—</span>}
                      </td>
                      <td className="ps-td">
                        <PaymentBadge status={plan?.payment_status || "unpaid"} expiryDate={plan?.plan_expiry} />
                      </td>
                      <td className="ps-td ps-td-meta">
                        {plan?.plan_expiry ? new Date(plan.plan_expiry).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" }) : <span style={{ color: "var(--ink-3)" }}>—</span>}
                      </td>
                      <td className="ps-td ps-td-meta">
                        {p.last_interaction ? new Date(p.last_interaction).toLocaleDateString("en-IN", { day: "2-digit", month: "2-digit", year: "numeric" }) : "Never"}
                      </td>
                    </>}
                    <td className="ps-td" style={{ position: "relative", textAlign: "center" }}>
                      <button className="ps-action-btn" style={{ padding: "6px 10px" }}
                        onClick={(e) => {
                          e.stopPropagation();
                          const rect = e.currentTarget.getBoundingClientRect();
                          setPopoverPos({ top: rect.bottom + window.scrollY, left: rect.left + window.scrollX - 100 });
                          setOpenAction(openAction === p.id ? null : p.id);
                        }}
                      >
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                          <circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/>
                        </svg>
                      </button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}

      {/* ── Pagination ── */}
      {pages > 1 && (
        <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: "8px", padding: "24px 0" }}>
          <button className="btn-secondary" onClick={() => load(page - 1)} disabled={page === 1}>← Prev</button>
          <span style={{ fontSize: "13px", color: "var(--ink-2)" }}>
            Page {page} of {pages} &nbsp;·&nbsp; {total} total
          </span>
          <button className="btn-secondary" onClick={() => load(page + 1)} disabled={page === pages}>Next →</button>
        </div>
      )}

    </div>
  );
}