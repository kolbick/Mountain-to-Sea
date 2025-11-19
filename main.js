document.addEventListener('DOMContentLoaded', () => {
  if (window.emailjs) {
    emailjs.init('-KYPzVEnWJendcTjS');
  }

  const yearEl = document.getElementById('year');
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }

  const contactForm = document.getElementById('contact-form');

  if (contactForm) {
    const contactStatus = document.getElementById('contact-status');

    contactForm.addEventListener('submit', function (e) {
      e.preventDefault();

      if (contactStatus) {
        contactStatus.textContent = 'Sending...';
        contactStatus.style.color = '';
      }

      emailjs
        .sendForm('service_yvt9tea', 'template_ecxsrfl', this)
        .then(() => {
          if (contactStatus) {
            contactStatus.textContent = 'Message sent. You will receive a response by email.';
            contactStatus.style.color = '#15803d';
          }
          contactForm.reset();
        })
        .catch(() => {
          if (contactStatus) {
            contactStatus.textContent = 'Something went wrong. Please try again later.';
            contactStatus.style.color = '#b91c1c';
          }
        });
    });
  }

  const scheduleForm = document.getElementById('schedule-form');

  if (scheduleForm) {
    const scheduleStatus = document.getElementById('schedule-status');
    const timeInput = document.getElementById('preferred_time');
    const timeButtons = document.querySelectorAll('.time-slot');

    timeButtons.forEach((btn) => {
      btn.addEventListener('click', () => {
        timeButtons.forEach((b) => b.classList.remove('selected'));
        btn.classList.add('selected');
        if (timeInput) {
          timeInput.value = btn.dataset.time || '';
        }
      });
    });

    scheduleForm.addEventListener('submit', function (e) {
      e.preventDefault();

      if (!timeInput || !timeInput.value) {
        if (scheduleStatus) {
          scheduleStatus.textContent = 'Please select a time.';
          scheduleStatus.style.color = '#b91c1c';
        }
        return;
      }

      if (scheduleStatus) {
        scheduleStatus.textContent = 'Sending...';
        scheduleStatus.style.color = '';
      }

      emailjs
        .sendForm('service_yvt9tea', 'template_nqhvpgo', this)
        .then(() => {
          if (scheduleStatus) {
            scheduleStatus.textContent = 'Request sent. You will receive a confirmation by email.';
            scheduleStatus.style.color = '#15803d';
          }
          scheduleForm.reset();
          timeButtons.forEach((b) => b.classList.remove('selected'));
          if (timeInput) timeInput.value = '';
        })
        .catch(() => {
          if (scheduleStatus) {
            scheduleStatus.textContent = 'Something went wrong. Please try again later.';
            scheduleStatus.style.color = '#b91c1c';
          }
        });
    });
  }
});
