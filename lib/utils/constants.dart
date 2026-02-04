import 'package:flutter/material.dart';

class AppData {
  static final List<Map<String, dynamic>> products = [
    {
      'id': 'hrms',
      'title': 'HR Management System',
      'subtitle': 'Workforce Excellence',
      'shortDesc':
          'Efficiently manage employee records, leave, claims, and payroll.',
      'fullDesc':
          'Efficiently manage employee records, inclusive of personal details, employment information, assets, and entitlement settings. Our HRMS streamlines everything from onboarding to performance tracking, ensuring a seamless experience for both HR and employees.',
      'icon': Icons.people,
      'color': const Color(0xFFD946EF),
      'features': [
        'Employee Management',
        'Leave Management',
        'Claims Management',
        'Attendance Management',
        'Payroll Management',
        'Advance Payment',
      ],
      'detailSections': [
        {
          'title': 'Employee Management',
          'description':
              'Comprehensive profiles for every employee. Track personal details, residency status, vehicle information, and family records. Streamline onboarding with bulk Excel imports and manage asset allocations efficiently.',
          'icon': Icons.badge,
          'image': 'assets/images/Employee-Management.png',
        },
        {
          'title': 'Leave Management',
          'description':
              'Flexible leave policy engine. Define custom entitlements with carry-forward rules. Automated workflows for submission, approval, and rejection. Syncs instantly with payroll for accurate deduction calculations.',
          'icon': Icons.event_available,
          'image': 'assets/images/Leave-Mangement.png',
        },
        {
          'title': 'Claims Management',
          'description':
              'Hassle-free reimbursement processing. Employees can upload receipts and track claim status in real-time. Admins benefit from automated limit checks and streamlined approval queues.',
          'icon': Icons.payments,
          'image': 'assets/images/Claim-management.png',
        },
        {
          'title': 'Payroll & Payslip',
          'description':
              'Precision payroll processing. Automate CTC breakdown including Basic, HRA, and statutory deductions like PF/ESI. Generate professional monthly payslips and manage advance salary requests seamlessly.',
          'icon': Icons.receipt_long,
          'image': 'assets/images/Payroll-management.png',
        },
        {
          'title': 'Attendance Management',
          'description':
              'Next-gen attendance tracking. Geofenced mobile check-ins ensure accuracy. Built-in shift scheduling and real-time attendance dashboards for team leads. Includes history logs and irregular entry alerts.',
          'icon': Icons.location_on,
          'image': 'assets/images/Attendance-management.png',
        },
        {
          'title': 'Performance Management',
          'description':
              'Drive growth with structured appraisals. Set OKRs and KPIs at department and individual levels. Conduct 360-degree feedback cycles and track progress with interactive performance charts.',
          'icon': Icons.trending_up,
          'image': 'assets/images/hrms_card_bg.png',
        },
        {
          'title': 'Training & Recruitment',
          'description':
              'End-to-end talent acquisition. Manage job postings, applicant tracking (ATS), and interview scheduling. Post-hiring, assign training modules and track certification progress for skills development.',
          'icon': Icons.school,
          'image': 'assets/images/hrms_card_bg.png',
        },
        {
          'title': 'Asset Management',
          'description':
              'Complete lifecycle tracking of company assets. From laptops to ID badges, monitor allocation, return dates, and maintenance history. Linked directly to employee profiles for easy audits.',
          'icon': Icons.devices,
          'image': 'assets/images/hrms_card_bg.png',
        },
        {
          'title': 'Reports & Analytics',
          'description':
              'Data-driven HR insights. Generate standard reports for headcount, turnover, and diversity. Custom report builder for specific queries and visual dashboards for executive transparency.',
          'icon': Icons.assessment,
          'image': 'assets/images/hrms_card_bg.png',
        },
      ],
      'image': 'assets/images/hrms_card_bg.png',
    },
    {
      'id': 'crm',
      'title': 'Customer Relationship',
      'subtitle': 'Sales Optimization',
      'shortDesc': 'Manage leads, opportunities, and quotes with ease.',
      'fullDesc':
          'Elevate customer relationships with our CRM system. Efficiently manage leads, opportunities, and quotes with customizable templates for rapid response. Leverage insights to drive growth and enhance client satisfaction.',
      'icon': Icons.handshake,
      'color': const Color(0xFFFB923C),
      'features': [
        'Lead Management',
        'Sales Pipeline',
        'Customer Support',
        'Analytics Dashboard',
      ],
      'image': 'assets/images/crm_card_bg.png',
    },
    {
      'id': 'pms',
      'title': 'Project Management',
      'subtitle': 'Agile Delivery',
      'shortDesc': 'Plan, execute, and monitor projects efficiently.',
      'fullDesc':
          'Boost project efficiency with our comprehensive suite including project planning, BOM management, task tracking, timeline visualization, invoicing, escalation handling, and customizable templates.',
      'icon': Icons.task,
      'color': const Color(0xFF3B82F6),
      'features': [
        'Task Management',
        'Gantt Charts',
        'Time Tracking',
        'Resource Allocation',
      ],
      'image': 'assets/images/pms_card_bg.png',
    },
    {
      'id': 'accounting',
      'title': 'Accounting & Finance',
      'subtitle': 'Financial Clarity',
      'shortDesc': 'Streamline financial operations and reporting.',
      'fullDesc':
          'Streamline your financial operations effortlessly using our Accounting module, encompassing Sales Orders, Invoices, Payment Receipts, Expenses, Purchase Orders, Bills, and beyond.',
      'icon': Icons.account_balance,
      'color': const Color(0xFF10B981),
      'features': [
        'Invoicing',
        'Expense Tracking',
        'Financial Reports',
        'Tax Management',
      ],
      'image': 'assets/images/accounting_card_bg.png',
    },
    {
      'id': 'inventory',
      'title': 'Inventory Management',
      'subtitle': 'Supply Chain Control',
      'shortDesc': 'Track stock levels and manage orders seamlessly.',
      'fullDesc':
          'Optimize inventory management with our solution, tracking stock, orders, and replenishment seamlessly. Gain real-time visibility, streamline operations, and boost customer satisfaction.',
      'icon': Icons.inventory,
      'color': const Color(0xFFF59E0B),
      'features': [
        'Stock Tracking',
        'Order Management',
        'Supplier Management',
        'Barcode Scanning',
      ],
      'image': 'assets/images/inventory_card_bg.png',
    },
  ];

  static Map<String, dynamic> getProductById(String id) {
    return products.firstWhere((p) => p['id'] == id, orElse: () => products[0]);
  }
}
