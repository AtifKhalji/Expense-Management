<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin User Management - Expense System</title>
    <style>
        /* CSS Provided by User, plus necessary additions for the page */
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

        /* The overall layout classes are not fully used here as we only build the Admin page, 
           but they are kept for consistency with the overall design plan. */
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

        /* Form Styling */
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

        /* Table Styling */
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
            background-color: #e9ecef; /* Based on your provided CSS */
            font-weight: 600;
            color: #333;
        }
        
        table thead th {
            background-color: #007bff; /* Custom color for header consistency */
            color: white;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }
        
        /* Action-specific styles for User Management */
        .action-btn { background-color: #ffc107; color: #333; }
        .action-btn:hover { background-color: #e0a800; }
        .delete-btn { background-color: #dc3545; color: white; }
        .delete-btn:hover { background-color: #c82333; }
        .status-pending { color: #ffc107; font-weight: bold; }
        .form-row { display: flex; gap: 15px; } /* Custom flex for the form layout */
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
        event.preventDefault(); // Prevents the page from reloading
        
        // 1. Get the values from the form inputs
        const name = document.getElementById('new-name').value.trim();
        const email = document.getElementById('new-email').value.trim();
        const role = document.getElementById('new-role').value;
        
        // Check if the input fields are empty
        if (!name || !email) {
            alert("Please enter both a full name and email address.");
            return; 
        }

        // 2. Reference the table body and remove the 'empty' placeholder row
        const tableBody = document.getElementById('userTableBody');
        const emptyRow = document.getElementById('empty-row');
        if (emptyRow) {
            emptyRow.remove();
        }

        // Simple way to generate a temporary ID (for demo purposes)
        const newID = role === 'Manager' ? 'MGR' + Math.floor(Math.random() * 1000) : 'EMP' + Math.floor(Math.random() * 1000);

        // 3. Create the new row HTML
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

        // 4. Insert the new row into the table
        tableBody.insertAdjacentHTML('beforeend', newRow);

        // 5. Clear the form for the next entry
        document.getElementById('new-name').value = '';
        document.getElementById('new-email').value = '';
        document.getElementById('new-role').value = 'Employee'; // Reset role dropdown
        document.getElementById('new-name').focus(); // Focus back to the name field
    });
</script>

</body>
</html>
