<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.LearningMaterial, dao.learningMaterialDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Learning Material</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://kit.fontawesome.com/7f80ec1f7e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="assets/css/home.css">
    <link rel="stylesheet" href="assets/css/learningMaterial.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <form action="updateLearningMaterial" method="post" enctype="multipart/form-data">
    <input type="hidden" id="updateId" name="updateId" value="${param.updateId}">
    <div class="form-group">
        <label for="updateName">Name:</label>
        <input type="text" class="form-control" id="updateName" name="updateName" value="${param.updateName}" required>
    </div>
    <div class="form-group">
        <label for="updateDescription">Description:</label>
        <textarea class="form-control" id="updateDescription" name="updateDescription" required>${param.updateDescription}</textarea>
    </div>
    <div class="form-group">
        <label for="updateSubjectCode">Subject Code:</label>
        <input type="text" class="form-control" id="updateSubjectCode" name="updateSubjectCode" value="${param.updateSubjectCode}" required>
    </div>
    <div class="form-group">
        <label for="updateDepartmentId">Department:</label>
        <select class="form-control" id="updateDepartmentId" name="updateDepartmentId" required>
            <option value="1" ${param.updateDepartmentId == 1 ? 'selected' : ''}>Economy</option>
            <option value="2" ${param.updateDepartmentId == 2 ? 'selected' : ''}>IT</option>
            <option value="3" ${param.updateDepartmentId == 3 ? 'selected' : ''}>Tourism</option>
            <option value="4" ${param.updateDepartmentId == 4 ? 'selected' : ''}>Languages</option>
        </select>
    </div>
    <div class="form-group">
        <label for="updateContext">Context File:</label>
        <input type="file" class="form-control" id="updateContext" name="updateContext">
    </div>
    <div class="form-group">
        <label for="updateReview">Review:</label>
        <input type="text" class="form-control" id="updateReview" name="updateReview" value="${param.updateReview}" required>
    </div>
    <button type="submit" class="btn btn-primary">Update</button>
</form>
</body>
</html>