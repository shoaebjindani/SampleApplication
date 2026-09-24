<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="employeeList" value='${requestScope["outputObject"].get("employeeList")}' />
<c:set var="todaysDate" value='${requestScope["outputObject"].get("todaysDate")}' />
<c:set var="lstCategoriesForMOM" value='${requestScope["outputObject"].get("lstCategoriesForMOM")}' />

<!DOCTYPE html>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
  <link href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

  <style>
    .agenda-card { border: 1px solid #ccc; margin-bottom: 15px; border-radius: 6px; }
    .agenda-header { background: #e9ecef; padding: 10px; font-weight: bold; cursor: pointer; }
    .agenda-body { display: none; padding: 15px; }
    .subsection-title { font-size: 14px; font-weight: 500; margin-bottom: 5px; }
    .input-group { margin-bottom: 10px; }
  </style>
</head>
<body>
<div class="container-fluid px-3 mt-3">
  <div class="card">
    <div class="card-body">      
      <form id="frm" action="?a=addMom" method="post" enctype="multipart/form-data" accept-charset="UTF-8" onsubmit="return handleFormSubmit()">
        <div class="form-row">
          <div class="form-group col-md-2">
            <label>MOM Date</label>
            <input type="text" name="momDate" readonly id="momDate" class="form-control" value="${todaysDate}" />
          </div>
          <div class="form-group col-md-2">
            <label>Initiated By</label>
            <select name="initiatedBy" class="form-control" required>
              <c:forEach var="user" items="${requestScope['outputObject'].get('userList')}">
                <option value="${user.user_id}">${user.username}</option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group col-md-2">
            <label>Category</label>
            <select name="category" id="category" class="form-control">                                          
            
            <c:forEach var="category" items="${lstCategoriesForMOM}">
                <option value="${category.id}">${category.name}</option>
              </c:forEach>           

              <option value="Supplier">Supplier</option>
              <option value="Customer">Customer</option>
            </select>
          </div>

          <div class="form-group col-md-2" name="divsupplier">
            <label>Select Supplier</label>
            <select name="supplier" id="supplier" class="form-control">
              <option value="">-- Select Supplier --</option>
              <c:forEach var="supplier" items="${requestScope['outputObject'].get('supplierList')}">
                <option value="${supplier.supplier_id}">${supplier.supplier_name}</option>
              </c:forEach>
            </select>
          </div>

          <div class="form-group col-md-2" name="divsupplier">
            <label>Supplier Contact Person</label>
            <input type="text" name="supplierContactPerson" class="form-control" placeholder="Contact Person" />
          </div>

          <div class="form-group col-md-2" name="divcustomer">
            <label>Select Customer</label>
            <select name="customer" id="customer" class="form-control">
              <option value="">-- Select Customer --</option>
              <c:forEach var="customer" items="${requestScope['outputObject'].get('customerList')}">
                <option value="${customer.customer_id}">${customer.customer_name}</option>
              </c:forEach>
            </select>
          </div>

          <div class="form-group col-md-2" name="divcustomer">
            <label>Customer Contact Person</label>
            <input type="text" name="customerContactPerson" class="form-control" placeholder="Contact Person" />
          </div>
        </div>

        <div class="form-group">
          <label>Attendees</label>
          <select class="form-control js-example-attendee-multiple" name="attendees[]" multiple required>
            <c:forEach var="user" items="${requestScope['outputObject'].get('userList')}">
              <option value="${user.user_id}">${user.username}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label>Agenda's</label>
          <div id="agendaWrapper"></div>
          <button type="button" class="btn btn-sm btn-secondary mt-2" onclick="addAgendaBlock('Agenda name Goes here')">+ Add Agenda</button>
        </div>

        <div class="form-group">
          <label>Conclusion</label>
          <textarea name="conclusion" rows="3" class="form-control" required></textarea>
        </div>

        <input type="hidden" name="agendaJson" id="agendaJson" />
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
    </div>
  </div>
</div>

<script>
let agendaIndex = 0;

function handleFormSubmit() {
  const agendaData = [];

  document.querySelectorAll('.agenda-card').forEach(card => {
    const body = card.querySelector('.agenda-body');
    const title = body.querySelector('input[name="agendaInput"]').value;
    const carryForward = body.querySelector('.carry-forward-checkbox').checked;

    const discussions = Array.from(body.querySelectorAll('input[name="discussionInput"]')).map(i => i.value.trim()).filter(v => v);
    const announcements = Array.from(body.querySelectorAll('input[name="announcementInput"]')).map(i => i.value.trim()).filter(v => v);

    const tasks = [];
    body.querySelectorAll('.task-container > .border').forEach(task => {
      tasks.push({
        task_name: task.querySelector('input[name="task_name"]').value,
        task_type: task.querySelector('select[name="task_type"]').value,
        task_date: task.querySelector('input.task-date').value,
        target_date: task.querySelector('input.target-date').value,
        assigned_to: task.querySelector('select[name="assigned_to"]').value,
        priority: task.querySelector('select[name="priority"]').value
      });
    });

    agendaData.push({
      title,
      carry_forward: carryForward,
      discussions,
      announcements,
      tasks
    });
  });
  document.getElementById('agendaJson').value = JSON.stringify(agendaData);
  return true;
}

function addAgendaBlock(agendaname) {
  const container = document.getElementById("agendaWrapper");
  const block = document.createElement("div");
  block.className = "agenda-card";

  const header = document.createElement("div");
  header.className = "agenda-header";
  header.innerText = "Agenda";

  const body = document.createElement("div");
  body.className = "agenda-body";

  body.innerHTML = `
    <div class="form-group">
      <input type="text" name="agendaInput" onkeyup="updateTitle(this)" class="form-control agenda-title" value="`+agendaname+`" placeholder="Enter agenda title" required />
      <input class="form-check-input carry-forward-checkbox" type="checkbox" onchange="toggleAgendaFields(this)" style="margin-top: 6px;" />
      <label class="form-check-label" style="margin-left: 5px;">Carry Forward</label>
    </div>
    <div class="form-group">
      <div class="subsection-title">Discussions</div>
      <div class="action-container"></div>
      <button type="button" class="btn btn-sm btn-outline-secondary" onclick="addSubInput(this, 'discussionInput')">+ Add Discussion</button>
    </div>
    <div class="form-group">
      <div class="subsection-title">Tasks</div>
      <div class="task-container"></div>
      <button type="button" class="btn btn-sm btn-outline-secondary" onclick="addTaskToAgenda(this)">+ Add Task</button>
    </div>
    <div class="form-group">
      <div class="subsection-title">Announcements</div>
      <div class="announcement-container"></div>
      <button type="button" class="btn btn-sm btn-outline-secondary" onclick="addSubInput(this, 'announcementInput')">+ Add Announcement</button>
    </div>
  `;

  

  header.onclick = () => {
    body.style.display = (body.style.display === "none" ? "block" : "none");
  };

  block.appendChild(header);
  block.appendChild(body);
  container.appendChild(block);

  var agendaInputs=document.getElementsByName("agendaInput");
  for(var k=0;k<agendaInputs.length;k++)
  {
    updateTitle(agendaInputs[k]);
  }
  
}

function addSubInput(btn, name) {
  const container = btn.previousElementSibling;
  const inputGroup = document.createElement("div");
  inputGroup.className = "input-group mb-2";
  inputGroup.innerHTML = `
    <input type="text" class="form-control" name="`+name+`" required />
    <div class="input-group-append">
      <button class="btn btn-danger" type="button" onclick="this.closest('.input-group').remove()">X</button>
    </div>
  `;
  container.appendChild(inputGroup);
}

function addTaskToAgenda(btn) {
  const taskContainer = btn.previousElementSibling;
  const taskBlock = document.createElement("div");
  taskBlock.className = "border p-2 mb-2 rounded bg-light";

  taskBlock.innerHTML = `
    <div class="form-row" style="align-items:center">
      <div class="form-group col-md-2"><input type="text" name="task_name" class="form-control" placeholder="Task Name" required></div>
      <div class="form-group col-md-2">
        <select name="task_type" class="form-control" required>
          <option>OneTime</option>
        </select>
      </div>
      <div class="form-group col-md-2"><input type="text" class="form-control task-date" placeholder="Task Date" readonly></div>
      <div class="form-group col-md-2"><input type="text" class="form-control target-date" placeholder="Target Date" readonly></div>
      <div class="form-group col-md-2">
        <select name="assigned_to" class="form-control" required>
          <c:forEach items="${employeeList}" var="emp">
            <option value="${emp.user_id}">${emp.username}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group col-md-1">
        <select name="priority" class="form-control" required>
          <option value="">Priority</option><option>Low</option><option>Medium</option><option>High</option><option>Urgent</option>
        </select>
      </div>
      <div class="form-group col-md-1">
        <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('.border').remove()">Remove Task</button>
      </div>
    </div>
  `;
  taskContainer.appendChild(taskBlock);
  $(taskBlock).find(".task-date").datepicker({ dateFormat: 'dd/mm/yy' });
  $(taskBlock).find(".target-date").datepicker({ dateFormat: 'dd/mm/yy' });
}

$(document).ready(function () {
  $('.js-example-attendee-multiple').select2({ placeholder: 'Select attendees', width: '100%' });
  $("#momDate").datepicker({ dateFormat: 'dd/mm/yy' });

  document.getElementById("category").addEventListener("change", function () {
    const val = this.value.toLowerCase();
    const supplierDivs = document.querySelectorAll('[name="divsupplier"]');
    const customerDivs = document.querySelectorAll('[name="divcustomer"]');    
    if (val === "supplier") {
      supplierDivs.forEach(div => div.style.display = "block");
      customerDivs.forEach(div => div.style.display = "none");
    } else if (val === "customer") {
      supplierDivs.forEach(div => div.style.display = "none");
      customerDivs.forEach(div => div.style.display = "block");
    } else {
      supplierDivs.forEach(div => div.style.display = "none");
      customerDivs.forEach(div => div.style.display = "none");
      
      $.ajax({
      url: '?a=getAgendaByCategory&category_id='+this.value,  // replace with your servlet or endpoint
      type: 'GET',
      dataType: 'json',
      success: function (response) {
        //console.log("Response received:", response);
        for(var m=0;m<response.length;m++)        
        {
          addAgendaBlock(response[m].mom_agenda_name);
          
        }        
      },
      error: function (xhr, status, error) {
        console.error("Error occurred:", status, error);
      }
    });


    }
  });

  document.getElementById("category").dispatchEvent(new Event("change"));
});

function updateTitle(textbox) {
  textbox.parentNode.parentNode.parentNode.childNodes[0].innerHTML = textbox.value;
}

function toggleAgendaFields(checkbox) {
  const agendaBody = checkbox.closest(".agenda-body");
  const inputs = agendaBody.querySelectorAll("input, select, textarea, button");
  inputs.forEach(input => {
    if (input !== checkbox && input.name !== "agendaInput") {
      input.disabled = checkbox.checked;
    }
  });
}
</script>
</body>
</html>
