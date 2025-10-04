<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin User Management - Expense System</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: sans-serif;
        }

        body {
            background-color: #f4f4f9;
            padding: 20px;
        }
        .page-container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        h1, h2 { 
            margin-bottom: 15px; 
            color: #333; 
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .primary-btn {
            background-color: #007bff;
            color: white;
        }
        .primary-btn:hover { background-color: #0056b3; }
        .report-table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #e9ecef; 
            font-weight: 600;
            color: #333;
        }
        table thead th {
            background-color: #007bff; 
            color: white;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }
        
        .action-btn { background-color: #ffc107; color: #333; }
        .action-btn:hover { background-color: #e0a800; }
        .delete-btn { background-color: #dc3545; color: white; }
        .delete-btn:hover { background-color: #c82333; }
        .status-pending { color: #ffc107; font-weight: bold; }
        .form-row { display: flex; gap: 15px; }
        .form-row .form-group { flex-grow: 1; }
        .add-user-btn-container { text-align: right; margin-top: 15px; }
    </style>
</head>
<body>

<div class="page-container">
    <h1>User Management Overview</h1>
    <hr>
    
    <form id="addUserForm">
        <h2>Add New User</h2>
        <div class="form-row">
            <div class="form-group">
                <label for="new-name">Full Name</label>
                <input type="text" id="new-name" placeholder="Enter Full Name" required>
            </div>
            <div class="form-group">
                <label for="new-email">Email Address</label>
                <input type="email" id="new-email" placeholder="Enter Email" required>
            </div>
            <div class="form-group" style="max-width: 200px;">
                <label for="new-role">Role</label>
                <select id="new-role">
                    <option value="Employee">Employee</option>
                    <option value="Manager">Manager</option>
                </select>
            </div>
        </div>
        <div class="add-user-btn-container">
            <button type="submit" class="btn primary-btn" id="provision-btn">Provision Account & Send Password</button>
        </div>
    </form>

    <hr style="margin-top: 20px;">
    
    <div class="report-table-container">
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Full Name</th>
                    <th>Email Address</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <tr id="empty-row">
                    <td colspan="6" style="text-align: center; color: #999;">
                        No users found. Add the first user above.
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
    document.getElementById('addUserForm').addEventListener('submit', function(event) {
        event.preventDefault(); 
        const name = document.getElementById('new-name').value.trim();
        const email = document.getElementById('new-email').value.trim();
        const role = document.getElementById('new-role').value;
        if (!name || !email) {
            alert("Please enter both a full name and email address.");
            return; 
        }
        const tableBody = document.getElementById('userTableBody');
        const emptyRow = document.getElementById('empty-row');
        if (emptyRow) {
            emptyRow.remove();
        }
        const newID = role === 'Manager' ? 'MGR' + Math.floor(Math.random() * 1000) : 'EMP' + Math.floor(Math.random() * 1000);
        const newRow = `
            <tr>
                <td>${newID}</td>
                <td>${name}</td>
                <td>${email}</td>
                <td><strong>${role}</strong></td>
                <td><span class="status-pending">Pending Invite</span></td>
                <td>
                    <button class="btn action-btn">Send Invitation</button>
                    <button class="btn delete-btn">Delete</button>
                </td>
            </tr>
        `;
        tableBody.insertAdjacentHTML('beforeend', newRow);
        document.getElementById('new-name').value = '';
        document.getElementById('new-email').value = '';
        document.getElementById('new-role').value = 'Employee'; 
        document.getElementById('new-name').focus(); 
    });
</script>
</body>
</html>
