<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap + jQuery + Select2 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<style>
  body {
    background-color: #eef3f8;
    font-family: 'Segoe UI', sans-serif;
  }

  .card {
    border: 1px solid #dee2e6;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    border-radius: 12px;
    background: #fff;
  }

  label.form-label {
    font-weight: 600;
    color: #333;
  }

  .form-select {
    border: 1px solid #ced4da !important;
    border-radius: 6px !important;
    padding: 6px 8px !important;
    transition: border-color .2s, box-shadow .2s;
  }

  .form-select:focus {
    border-color: #80bdff !important;
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25) !important;
  }

  /* Customize Select2 Container and input fields to be clean and proper */
  .select2-container--bootstrap-5 .select2-selection {
    border: 1px solid #ced4da !important;
    border-radius: 6px !important;
    min-height: 38px !important;
    display: flex !important;
    align-items: center !important;
    background-color: #fff !important;
  }

  .select2-container--bootstrap-5.select2-container--focus .select2-selection {
    border-color: #86b7fe !important;
    box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25) !important;
  }

  /* User-friendly soft colored pills for selection tags */
  .select2-container--bootstrap-5 .select2-selection--multiple .select2-selection__choice {
    background-color: #e0e7ff !important; /* Soft indigo tint */
    color: #4338ca !important;            /* Deep indigo text */
    border: 1px solid #c7d2fe !important;
    border-radius: 6px !important;
    padding: 2px 8px !important;
    font-size: 0.85rem !important;
    font-weight: 500 !important;
    margin: 3px 4px 3px 0 !important;
    display: inline-flex !important;
    align-items: center !important;
  }

  .select2-container--bootstrap-5 .select2-selection--multiple .select2-selection__choice__remove {
    color: #4338ca !important;
    border-right: 1px solid #c7d2fe !important;
    padding-right: 6px !important;
    margin-right: 4px !important;
    font-weight: bold !important;
  }

  .select2-container--bootstrap-5 .select2-selection--multiple .select2-selection__choice__remove:hover {
    background-color: #c7d2fe !important;
    color: #312e81 !important;
  }

  /* Dropdown container */
  .select2-dropdown {
    border: 1px solid #dee2e6 !important;
    border-radius: 8px !important;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08) !important;
    z-index: 9999 !important;
  }

  /* List items */
  .select2-results__option {
    padding: 8px 12px !important;
    font-size: 0.9rem !important;
    color: #333 !important;
  }

  /* Soft friendly highlight selection on hover */
  .select2-results__option--highlighted {
    background-color: #e0e7ff !important;
    color: #1f2937 !important;
  }

  /* Selected state indicator inside dropdown - force visibility and style */
  .select2-container--bootstrap-5 .select2-results__option[aria-selected=true],
  .select2-results__option[aria-selected=true] {
    display: block !important;
    background-color: #f8fafc;
    color: #0f172a;
    font-weight: 500;
  }

  /* Checkbox styling for multi-select options in dropdown */
  .custom-checkbox {
    width: 16px;
    height: 16px;
    border: 1.5px solid #cbd5e1;
    border-radius: 4px;
    background-color: #fff;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    margin-right: 10px;
    transition: background-color 0.15s, border-color 0.15s;
  }

  /* Checked state based on selection */
  .custom-checkbox.checked,
  .select2-results__option[aria-selected=true] .custom-checkbox {
    background-color: #4f46e5;
    border-color: #4f46e5;
  }

  .custom-checkbox.checked::after,
  .select2-results__option[aria-selected=true] .custom-checkbox::after {
    content: "\2713";
    color: #fff;
    font-size: 11px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  /* Prevent checked state on hover/highlight if it wasn't actually selected (doesn't have .checked class) */
  .select2-results__option--highlighted[aria-selected=true] .custom-checkbox:not(.checked) {
    background-color: #fff !important;
    border-color: #cbd5e1 !important;
  }
  .select2-results__option--highlighted[aria-selected=true] .custom-checkbox:not(.checked)::after {
    content: "" !important;
  }

  /* Options list scrollbar and height */
  .select2-results__options {
    max-height: 250px !important;
    overflow-y: auto !important;
  }

  .select2-results__options::-webkit-scrollbar {
    width: 6px;
  }

  .select2-results__options::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 4px;
  }

  .select2-results__options::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 4px;
  }

  .select2-results__options::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
  }

  .btn-primary {
    background-color: #007bff;
    border: none;
  }

  .btn-primary:hover {
    background-color: #0069d9;
  }
</style>

<c:set var="userList" value='${requestScope["outputObject"].get("userList")}' />
<c:set var="roleList" value='${requestScope["outputObject"].get("roleList")}' />
<c:set var="actionList" value='${requestScope["outputObject"].get("actionList")}' />

<div class="container py-5">
  <div class="card p-4 mx-auto" style="max-width: 600px;">    

    <!-- User Selection -->
    <div class="mb-4">
      <label class="form-label">Select User</label>
      <select id="userSelect" class="form-select">
        <option value="">Search or Select User</option>
        <c:forEach items="${userList}" var="user">
          <option value="${user.user_id}">${user.username} - ${user.name}</option>
        </c:forEach>
      </select>
    </div>

    <!-- Role Selection -->
    <div class="mb-4">
      <label class="form-label">Assigned Roles</label>
      <select id="roleSelect" class="form-select" multiple>
        <c:forEach var="entry" items="${roleList}">
          <option value="${entry.key}">${entry.value.roleName}</option>
        </c:forEach>
      </select>
    </div>

    <!-- Additional Actions Selection -->
    <div class="mb-4">
      <label class="form-label">Additional Actions</label>
      <select id="actionSelect" class="form-select" multiple>
        <c:forEach var="actionName" items="${actionList}">
          <option value="${actionName}">${actionName}</option>
        </c:forEach>
      </select>
    </div>

    <!-- Buttons -->
    <div class="d-flex justify-content-center gap-3">
      <button type="button" class="btn btn-primary px-4" onclick="saveRole()">Save</button>
      <button type="button" class="btn btn-outline-secondary px-4" onclick="resetPage()">Reset</button>
    </div>
  </div>
</div>

<script>
  if (document.getElementById("divTitle")) {
    document.getElementById("divTitle").innerHTML = "User Role Mapping";
  }

  $(document).ready(function () {
    $('#userSelect').select2({
      placeholder: "Search or select user",
      allowClear: true,
      theme: 'bootstrap-5',
      width: '100%'
    }).on('change', function () {
      const userId = $(this).val();
      if (userId) getRolesForUser(userId);
      else {
        $('#roleSelect').val(null).trigger('change');
        $('#actionSelect').val(null).trigger('change');
      }
    });

    function formatDropdownOption(state) {
      if (!state.id) {
        return state.text;
      }
      var isSelected = state.selected || (state.element && state.element.selected);
      var checkboxClass = isSelected ? 'custom-checkbox checked' : 'custom-checkbox';
      return $(
        '<div class="d-flex align-items-center dropdown-option-wrapper" data-id="' + state.id + '">' +
          '<span class="' + checkboxClass + '"></span>' +
          '<span>' + state.text + '</span>' +
        '</div>'
      );
    }

    $('#roleSelect').select2({
      placeholder: "Assign roles to user",
      theme: 'bootstrap-5',
      width: '100%',
      closeOnSelect: false,
      templateResult: formatDropdownOption
    });

    $('#actionSelect').select2({
      placeholder: "Assign additional actions directly to user",
      theme: 'bootstrap-5',
      width: '100%',
      closeOnSelect: false,
      templateResult: formatDropdownOption
    });

    // Listen to select/unselect events to toggle the checked class on the checkbox span dynamically
    $('#roleSelect, #actionSelect').on('select2:select', function (e) {
      const optionId = e.params.data.id;
      const select2Instance = $(this).data('select2');
      if (select2Instance && select2Instance.$results) {
        select2Instance.$results.find('.dropdown-option-wrapper[data-id="' + optionId + '"]')
          .find('.custom-checkbox').addClass('checked');
      }
    }).on('select2:unselect', function (e) {
      const optionId = e.params.data.id;
      const select2Instance = $(this).data('select2');
      if (select2Instance && select2Instance.$results) {
        select2Instance.$results.find('.dropdown-option-wrapper[data-id="' + optionId + '"]')
          .find('.custom-checkbox').removeClass('checked');
      }
    });
  });

  function getRolesForUser(userId) {
    fetch("?a=getRoleDetailsForthisUser&userId=" + encodeURIComponent(userId))
      .then(resp => resp.json())
      .then(data => {
        const roleSelect = $('#roleSelect');
        roleSelect.val(null).trigger('change');
        if (Array.isArray(data.lstUserRoleDetails)) {
          const assignedIds = data.lstUserRoleDetails.map(r => String(r.role_id));
          roleSelect.val(assignedIds).trigger('change');
        }

        const actionSelect = $('#actionSelect');
        actionSelect.val(null).trigger('change');
        if (Array.isArray(data.lstUserCustomActions)) {
          actionSelect.val(data.lstUserCustomActions).trigger('change');
        }
      })
      .catch(err => {
        console.error(err);
        alert("Failed to load roles and actions for user.");
      });
  }

  function saveRole() {
    const userId = $('#userSelect').val();
    if (!userId) { alert("Please select a user first."); return; }

    const selectedIds = $('#roleSelect').val() || [];
    const selectedActions = $('#actionSelect').val() || [];
    const payload = "?a=addRemoveRole&userId=" + encodeURIComponent(userId)
      + "&listOFRoles=" + encodeURIComponent(selectedIds.join(","))
      + "&listOfActions=" + encodeURIComponent(selectedActions.join(","));

    fetch(payload)
      .then(resp => resp.text())
      .then(msg => {
        alert(" " + msg);
        getRolesForUser(userId);
      })
      .catch(err => {
        console.error(err);
        alert("Failed to save roles and actions.");
      });
  }

  function resetPage() {
    $('#userSelect').val(null).trigger('change');
    $('#roleSelect').val(null).trigger('change');
    $('#actionSelect').val(null).trigger('change');
  }
</script>
