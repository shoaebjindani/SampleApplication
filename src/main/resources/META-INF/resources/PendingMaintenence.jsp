<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="listofdefaulters" value='${requestScope["outputObject"].listofdefaulters}' />
<c:set var="blockList" value='${requestScope["outputObject"].blockList}' />

<script>
/* The guest layout may not declare a viewport, which makes phones render the
   page at desktop width. Add it if it's missing so the mobile styles apply. */
(function () {
    var meta = document.querySelector('meta[name="viewport"]');
    if (!meta) {
        meta = document.createElement("meta");
        meta.name = "viewport";
        document.head.appendChild(meta);
    }
    meta.content = "width=device-width, initial-scale=1";
})();
</script>

<style>
    /* Everything is scoped under .pm so it can't leak into the guest page */
    .pm {
        --pm-ink: #1f2933;
        --pm-muted: #6b7785;
        --pm-line: #e3e7ec;
        --pm-surface: #ffffff;
        --pm-soft: #f5f7fa;
        --pm-alert: #a63d2f;
        --pm-alert-soft: #fbecea;
        --pm-accent: #24546b;
        color: var(--pm-ink);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        max-width: 1100px;
        width: 100%;
        overflow-wrap: anywhere;
        margin: 0 auto;
        padding: 12px;
    }

    .pm *, .pm *::before, .pm *::after { box-sizing: border-box; }

    /* ---------- Summary + filter ---------- */
    .pm-top {
        display: grid;
        grid-template-columns: 1fr auto;
        gap: 16px;
        align-items: end;
        margin-bottom: 16px;
    }

    .pm-filter label {
        display: block;
        font-size: .85rem;
        color: var(--pm-muted);
        margin-bottom: 6px;
    }

    .pm-filter select {
        width: 100%;
        max-width: 320px;
        height: 44px;
        padding: 0 36px 0 12px;
        border: 1px solid var(--pm-line);
        border-radius: 8px;
        background-color: var(--pm-surface);
        color: var(--pm-ink);
        font-size: 1rem;
        appearance: none;
        -webkit-appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' fill='none' stroke='%236b7785' stroke-width='1.8' stroke-linecap='round'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 12px center;
    }

    .pm-filter select:focus-visible {
        outline: 3px solid rgba(36, 84, 107, .35);
        outline-offset: 1px;
        border-color: var(--pm-accent);
    }

    .pm-totals {
        display: flex;
        gap: 12px;
    }

    .pm-stat {
        min-width: 150px;
        padding: 10px 16px;
        border-radius: 10px;
        background: var(--pm-soft);
        border: 1px solid var(--pm-line);
    }

    .pm-stat.is-alert {
        background: var(--pm-alert-soft);
        border-color: #f0cdc8;
    }

    .pm-stat-value {
        display: block;
        font-size: 1.9rem;
        font-weight: 700;
        line-height: 1.1;
        font-variant-numeric: tabular-nums;
    }

    .pm-stat.is-alert .pm-stat-value { color: var(--pm-alert); }

    .pm-stat-label {
        display: block;
        margin-top: 2px;
        font-size: .82rem;
        color: var(--pm-muted);
    }

    /* ---------- Table (desktop / tablet) ---------- */
    .pm-table-wrap {
        border: 1px solid var(--pm-line);
        border-radius: 12px;
        overflow: hidden;
        background: var(--pm-surface);
    }

    .pm-table {
        width: 100%;
        border-collapse: collapse;
    }

    .pm-table thead th {
        position: sticky;
        top: 0;
        padding: 12px 16px;
        background: var(--pm-accent);
        color: #fff;
        font-size: .9rem;
        font-weight: 600;
        text-align: left;
        white-space: nowrap;
    }

    .pm-table tbody td {
        padding: 12px 16px;
        border-top: 1px solid var(--pm-line);
        vertical-align: top;
    }

    .pm-table tbody tr:nth-child(even) td { background: #fafbfc; }
    .pm-table tbody tr:hover td { background: #eef3f6; }

    .pm-owner { font-weight: 600; }

    .pm-block {
        display: inline-block;
        padding: 2px 10px;
        border-radius: 999px;
        background: var(--pm-soft);
        border: 1px solid var(--pm-line);
        font-size: .88rem;
        white-space: nowrap;
    }

    .pm-months {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
    }

    .pm-chip {
        padding: 2px 9px;
        border-radius: 6px;
        background: var(--pm-alert-soft);
        color: var(--pm-alert);
        font-size: .82rem;
        font-weight: 600;
        white-space: nowrap;
    }

    .pm-empty {
        display: none;
        padding: 40px 16px;
        text-align: center;
        color: var(--pm-muted);
    }

    .pm-empty.is-visible { display: block; }

    /* ---------- Phones: each row becomes a card ---------- */
    @media (max-width: 767.98px) {
        .pm { padding: 8px; }

        .pm-top {
            grid-template-columns: 1fr;
            gap: 12px;
        }

        .pm-filter select { max-width: none; }

        .pm-totals { display: grid; grid-template-columns: 1fr 1fr; }
        .pm-stat { min-width: 0; }

        .pm-table-wrap {
            border: 0;
            background: transparent;
            border-radius: 0;
        }

        .pm-table thead {
            /* keep for screen readers, hide visually */
            position: absolute;
            width: 1px; height: 1px;
            overflow: hidden;
            clip: rect(0 0 0 0);
        }

        .pm-table,
        .pm-table tbody,
        .pm-table tr,
        .pm-table td { display: block; width: 100%; }

        .pm-table tbody tr {
            margin-bottom: 12px;
            padding: 12px 14px;
            border: 1px solid var(--pm-line);
            border-radius: 12px;
            background: var(--pm-surface);
        }

        .pm-table tbody tr:nth-child(even) td,
        .pm-table tbody tr:hover td { background: transparent; }

        .pm-table tbody td {
            display: flex;
            gap: 12px;
            justify-content: space-between;
            align-items: flex-start;
            padding: 6px 0;
            border-top: 0;
            text-align: right;
        }

        .pm-table tbody td::before {
            content: attr(data-label);
            flex: 0 0 38%;
            text-align: left;
            font-size: .82rem;
            color: var(--pm-muted);
        }

        .pm-table tbody td.pm-owner-cell {
            padding-bottom: 10px;
            margin-bottom: 4px;
            border-bottom: 1px solid var(--pm-line);
            font-size: 1.05rem;
        }

        .pm-table tbody td.pm-owner-cell::before { display: none; }
        .pm-table tbody td.pm-owner-cell .pm-owner { width: 100%; text-align: left; }

        .pm-months { justify-content: flex-end; }
    }

    @media (prefers-reduced-motion: reduce) {
        .pm * { transition: none !important; }
    }
</style>

<div class="pm">

    <div class="pm-top">
        <div class="pm-filter">
            <label for="blockFilter">Block</label>
            <select id="blockFilter" onchange="updatePendingCount()">
                <option value="">All blocks</option>
                <c:forEach var="b" items="${blockList}">
                    <option value="<c:out value='${b}'/>"><c:out value="${b}"/></option>
                </c:forEach>
            </select>
        </div>

        <div class="pm-totals" aria-live="polite">
            <div class="pm-stat">
                <span class="pm-stat-value" id="flatCount">0</span>
                <span class="pm-stat-label">Flats with dues</span>
            </div>
            <div class="pm-stat is-alert">
                <span class="pm-stat-value" id="pendingCount">0</span>
                <span class="pm-stat-label">Pending months</span>
            </div>
        </div>
    </div>

    <div class="pm-table-wrap">
        <table id="pendingTable" class="pm-table">
            <thead>
                <tr>
                    <th scope="col">Owner</th>
                    <th scope="col">Block</th>
                    <th scope="col">Flat No</th>
                    <th scope="col">Year</th>
                    <th scope="col">Pending Months</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${listofdefaulters}">
                    <tr>
                        <td class="pm-owner-cell" data-label="Owner"><span class="pm-owner"><c:out value="${row.ownerName}"/></span></td>
                        <td data-label="Block"><span class="pm-block"><c:out value="${row.BlockName}"/></span></td>
                        <td data-label="Flat No"><c:out value="${row.FlatNo}"/></td>
                        <td data-label="Year"><c:out value="${row.yrname}"/></td>
                        <td data-label="Pending Months"><c:out value="${row.PendingMonths}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pmEmpty" class="pm-empty">No pending dues for this block.</div>
    </div>
</div>

<script>
(function () {
    var tbody = document.querySelector("#pendingTable tbody");

    // Turn "Jan, Feb, Mar" into individual chips (done once, on load)
    function buildChips() {
        tbody.querySelectorAll("tr").forEach(function (row) {
            var cell = row.children[4];
            var raw = cell.textContent.trim();
            var months = raw.split(",").map(function (m) { return m.trim(); }).filter(Boolean);

            row.setAttribute("data-months", months.length);
            cell.textContent = "";

            var wrap = document.createElement("div");
            wrap.className = "pm-months";
            months.forEach(function (m) {
                var chip = document.createElement("span");
                chip.className = "pm-chip";
                chip.textContent = m;
                wrap.appendChild(chip);
            });
            cell.appendChild(wrap);
        });
    }

    window.updatePendingCount = function () {
        var selected = document.getElementById("blockFilter").value.trim().toLowerCase();
        var flats = 0, total = 0;

        tbody.querySelectorAll("tr").forEach(function (row) {
            var block = row.children[1].textContent.trim().toLowerCase();
            var matches = selected === "" || block.includes(selected);

            row.style.display = matches ? "" : "none";

            if (matches) {
                flats++;
                total += parseInt(row.getAttribute("data-months"), 10) || 0;
            }
        });

        document.getElementById("flatCount").textContent = flats;
        document.getElementById("pendingCount").textContent = total;
        document.getElementById("pmEmpty").classList.toggle("is-visible", flats === 0);
    };

    window.addEventListener("load", function () {
        var title = document.getElementById("divTitle");
        if (title) title.innerHTML = "Pending Maintenance";

        buildChips();
        window.updatePendingCount();
    });
})();
</script>
