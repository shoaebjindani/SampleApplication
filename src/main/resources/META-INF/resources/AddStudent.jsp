
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
</head>

<body>

<div class="container" style="padding:20px; background-color:white;">

    <form id="frm" action="?a=addStudent" method="post"
          accept-charset="UTF-8">

        <input type="hidden" name="app_id" value="${userdetails.app_id}">
        <input type="hidden" name="user_id" value="${userdetails.user_id}">
        <input type="hidden" name="hdnStudentId"
               value="${studentDetails.student_id}">

        <!-- Student Name -->
        <div class="row">
            <div class="col-sm-12">
                <div class="form-group">
                    <label for="txtStudentName">Student Name</label>
                    <input type="text"
                           class="form-control"
                           id="txtStudentName"
                           name="txtStudentName"
                           value="${studentDetails.student_name}"
                           placeholder="Enter student name"
                           required>
                </div>
            </div>

            <!-- Email -->
            <div class="col-sm-12">
                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <input type="email"
                           class="form-control"
                           id="txtEmail"
                           name="txtEmail"
                           value="${studentDetails.email}"
                           placeholder="Enter email address"
                           required>
                </div>
            </div>

            <!-- Phone -->
            <div class="col-sm-12">
                <div class="form-group">
                    <label for="txtPhone">Phone Number</label>
                    <input type="tel"
                           class="form-control"
                           id="txtPhone"
                           name="txtPhone"
                           value="${studentDetails.phone}"
                           placeholder="Enter phone number">
                </div>
            </div>

            <!-- Course -->
            <div class="col-sm-12">
                <div class="form-group">
                    <label for="drpCourse">Course</label>
                    <select class="form-control"
                            id="drpCourse"
                            name="drpCourse"
                            required>
                        <option value="">Select Course</option>
                        <option value="BCA">BCA</option>
                        <option value="BBA">BBA</option>
                        <option value="BTECH">B.Tech</option>
                        <option value="MBA">MBA</option>
                    </select>
                </div>
            </div>

            <!-- Actions -->
            <div class="col-sm-12">

                <c:if test="${action ne 'Update'}">
                    <button class="btn btn-success" type="submit">
                        Save
                    </button>

                    <button class="btn btn-danger"
                            type="button"
                            onclick="window.location='?a=showStudentMaster'">
                        Cancel
                    </button>
                </c:if>

                <c:if test="${action eq 'Update'}">
                    <button class="btn btn-success" type="submit">
                        Update
                    </button>

                    <button class="btn btn-danger"
                            type="button"
                            onclick="window.location='?a=showStudentMaster'">
                        Cancel
                    </button>
                </c:if>

            </div>
        </div>
    </form>
</div>

<script>
    document.getElementById("divTitle").innerHTML =
        "${action eq 'Update' ? 'Update Student' : 'Add Student'}";

    document.getElementById("drpCourse").value =
        "${studentDetails.course}";
</script>

</body>
</html>
