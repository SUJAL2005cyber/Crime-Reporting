/**
 * Crime Reporting System — general UI behaviors (non-validation).
 */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    // Highlight the current page in the navbar
    const currentPage = window.location.pathname.split('/').pop() || 'index.jsp';
    document.querySelectorAll('.navbar-cts .nav-link').forEach(link => {
      const href = link.getAttribute('href');
      if (href && href.indexOf(currentPage) !== -1) {
        link.classList.add('active');
      }
    });

    // Auto-dismiss success/info alerts after 6 seconds
    document.querySelectorAll('.alert-auto-dismiss').forEach(alertEl => {
      setTimeout(() => {
        const bsAlert = bootstrap.Alert.getOrCreateInstance(alertEl);
        bsAlert.close();
      }, 6000);
    });

    // Prevent selecting a future date in incident-date pickers
    document.querySelectorAll('input[type="date"].no-future').forEach(input => {
      const today = new Date().toISOString().split('T')[0];
      input.setAttribute('max', today);
    });

    // Copy Case ID to clipboard (report success page / tracker)
    document.querySelectorAll('.copy-case-id').forEach(btn => {
      btn.addEventListener('click', function () {
        const caseId = btn.dataset.caseId;
        navigator.clipboard.writeText(caseId).then(() => {
          const original = btn.innerHTML;
          btn.innerHTML = '<i class="bi bi-check2"></i> Copied';
          setTimeout(() => { btn.innerHTML = original; }, 1800);
        });
      });
    });

    // Simple client-side filter for admin dashboard table (by status)
    const statusFilter = document.getElementById('statusFilter');
    if (statusFilter) {
      statusFilter.addEventListener('change', function () {
        const value = statusFilter.value;
        document.querySelectorAll('#reportsTable tbody tr').forEach(row => {
          const rowStatus = row.dataset.status;
          row.style.display = (value === 'all' || rowStatus === value) ? '' : 'none';
        });
      });
    }

    // Search box for admin dashboard table (by case ID / name / crime type)
    const searchBox = document.getElementById('reportSearch');
    if (searchBox) {
      searchBox.addEventListener('input', function () {
        const term = searchBox.value.trim().toLowerCase();
        document.querySelectorAll('#reportsTable tbody tr').forEach(row => {
          row.style.display = row.innerText.toLowerCase().includes(term) ? '' : 'none';
        });
      });
    }
  });
})();
