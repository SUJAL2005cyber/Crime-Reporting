(function() {

	'use strict';


	// =====================================================
	// REGULAR EXPRESSIONS
	// =====================================================

	const EMAIL_REGEX =
		/^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$/;


	const PHONE_REGEX =
		/^[6-9]\d{9}$/;


	const PASSWORD_REGEX = {

		upper: /[A-Z]/,

		lower: /[a-z]/,

		digit: /\d/,

		special: /[!@#$%^&*()_+\-=]/

	};


	// =====================================================
	// FILE SETTINGS
	// =====================================================

	const MAX_FILE_SIZE_MB = 100;


	const ALLOWED_EXTENSIONS = [

		'jpg',
		'jpeg',
		'png',
		'pdf',
		'docx',
		'mp4'

	];



	// =====================================================
	// FIELD VALIDATION DISPLAY
	// =====================================================

	function setFieldState(
		field,
		feedbackElement,
		valid,
		message
	) {

		field.classList.remove(
			'is-valid',
			'is-invalid'
		);


		field.classList.add(
			valid
				? 'is-valid'
				: 'is-invalid'
		);


		if (feedbackElement) {

			feedbackElement.textContent =
				message || '';

		}

	}



	function feedbackFor(field) {


		const explicit =
			document.querySelector(
				`[data-feedback-for="${field.id}"]`
			);


		if (explicit) {

			return explicit;

		}


		if (!field.parentElement) {

			return null;

		}


		return field.parentElement
			.querySelector(
				'.invalid-feedback'
			);

	}



	// =====================================================
	// VALIDATORS
	// =====================================================

	const validators = {


		required(value, label) {


			const valid =
				value !== null &&
				value.trim().length > 0;


			return {

				valid: valid,

				message:
					valid
						? ''
						: `${label} is required.`

			};

		},


		fullName(value) {


			const valid =
				value.trim().length >= 3;


			return {

				valid: valid,

				message:
					valid
						? ''
						: 'Full name must be at least 3 characters.'

			};

		},


		email(value) {


			const valid =
				EMAIL_REGEX.test(
					value.trim()
				);


			return {

				valid: valid,

				message:
					valid
						? ''
						: 'Enter a valid email address.'

			};

		},


		phone(value) {


			const valid =
				PHONE_REGEX.test(
					value.trim()
				);


			return {

				valid: valid,

				message:
					valid
						? ''
						: 'Enter a valid 10-digit mobile number.'

			};

		},


		address(value) {


			const valid =
				value.trim().length >= 5;


			return {

				valid: valid,

				message:
					valid
						? ''
						: 'Address must be at least 5 characters.'

			};

		},


		password(value) {


			const checks = [

				value.length >= 8,

				PASSWORD_REGEX.upper.test(value),

				PASSWORD_REGEX.lower.test(value),

				PASSWORD_REGEX.digit.test(value),

				PASSWORD_REGEX.special.test(value)

			];


			const valid =
				checks.every(Boolean);


			return {

				valid: valid,

				message:
					valid
						? ''
						: 'Min 8 chars with uppercase, lowercase, number and special character.'

			};

		},


		confirmPassword(
			value,
			label,
			form
		) {


			const password =
				form.querySelector(
					'[name="password"]'
				);


			const valid =
				password &&
				value === password.value &&
				value.length > 0;


			return {

				valid: valid,

				message:
					valid
						? ''
						: 'Passwords do not match.'

			};

		},


		pastDate(value, label) {


			if (!value) {

				return {

					valid: false,

					message:
						`${label} is required.`

				};

			}


			const today =
				new Date();


			today.setHours(
				23,
				59,
				59,
				999
			);


			const selectedDate =
				new Date(value);


			const valid =
				selectedDate <= today;


			return {

				valid: valid,

				message:
					valid
						? ''
						: `${label} cannot be in the future.`

			};

		},


		minLength(
			value,
			label,
			form,
			minimum
		) {


			const valid =
				value.trim().length >= minimum;


			return {

				valid: valid,

				message:
					valid
						? ''
						: `${label} must be at least ${minimum} characters.`

			};

		}

	};



	// =====================================================
	// RUN VALIDATOR
	// =====================================================

	function runValidator(field) {


		const rule =
			field.dataset.validate;


		if (!rule) {

			return true;

		}


		const label =
			field.dataset.label ||
			field.name;


		const form =
			field.closest('form');


		let result;


		if (rule === 'minLength') {


			const minimum =
				parseInt(
					field.dataset.min || '0',
					10
				);


			result =
				validators.minLength(
					field.value,
					label,
					form,
					minimum
				);

		}

		else if (validators[rule]) {


			result =
				validators[rule](
					field.value,
					label,
					form
				);

		}

		else {


			result = {

				valid: true,

				message: ''

			};

		}


		setFieldState(

			field,

			feedbackFor(field),

			result.valid,

			result.message

		);


		return result.valid;

	}



	// =====================================================
	// PASSWORD STRENGTH
	// =====================================================

	function initPasswordStrength() {


		const passwordField =
			document.getElementById(
				'password'
			);


		const bar =
			document.querySelector(
				'.password-strength-bar .fill'
			);


		const label =
			document.getElementById(
				'passwordStrengthLabel'
			);


		if (!passwordField || !bar) {

			return;

		}


		passwordField.addEventListener(
			'input',
			function() {


				const value =
					passwordField.value;


				let score = 0;


				if (value.length >= 8) {

					score++;

				}


				if (
					PASSWORD_REGEX.upper
						.test(value)
				) {

					score++;

				}


				if (
					PASSWORD_REGEX.lower
						.test(value)
				) {

					score++;

				}


				if (
					PASSWORD_REGEX.digit
						.test(value)
				) {

					score++;

				}


				if (
					PASSWORD_REGEX.special
						.test(value)
				) {

					score++;

				}


				const percentage =
					(score / 5) * 100;


				bar.style.width =
					percentage + '%';


				let color =
					'#b3261e';


				let text =
					'Weak';


				if (score >= 5) {


					color =
						'#2e7d46';


					text =
						'Strong';

				}

				else if (score >= 3) {


					color =
						'#c89b3c';


					text =
						'Moderate';

				}


				bar.style.backgroundColor =
					color;


				if (label) {


					label.textContent =
						value
							? text
							: '';


					label.style.color =
						color;

				}

			}
		);

	}


	function initEvidenceSelection() {


		const fileInput =
			document.getElementById(
				'evidenceFiles'
			);


		const evidenceContainer =
			document.getElementById(
				'evidenceChips'
			);


		const errorElement =
			document.getElementById(
				'evidenceError'
			);


		if (
			!fileInput ||
			!evidenceContainer ||
			!errorElement
		) {

			return;

		}


		/*
		 * DataTransfer lets us keep multiple files
		 * and remove individual files.
		 */
		let selectedFiles =
			new DataTransfer();



		// -------------------------------------------------
		// DISPLAY SELECTED FILES
		// -------------------------------------------------

		function displayFiles() {


			/*
			 * Update the real file input.
			 *
			 * These files will be submitted
			 * to ReportCrimeServlet.
			 */
			fileInput.files =
				selectedFiles.files;


			evidenceContainer.innerHTML =
				'';


			Array.from(
				selectedFiles.files
			)
				.forEach(
					function(
						file,
						index
					) {


						const sizeMB =
							file.size /
							(1024 * 1024);


						/*
						 * Create selected-file box.
						 */
						const fileBox =
							document.createElement(
								'div'
							);


						fileBox.className =
							'alert alert-light border ' +
							'd-flex justify-content-between ' +
							'align-items-center py-2 mb-2';



						/*
						 * Left side containing filename.
						 */
						const fileInformation =
							document.createElement(
								'div'
							);


						const icon =
							document.createElement(
								'i'
							);


						icon.className =
							'bi bi-paperclip me-2 text-primary';


						fileInformation.appendChild(
							icon
						);


						fileInformation.appendChild(

							document.createTextNode(

								file.name +

								' (' +

								sizeMB.toFixed(2) +

								' MB)'

							)

						);



						/*
						 * Remove button.
						 */
						const removeButton =
							document.createElement(
								'button'
							);


						removeButton.type =
							'button';


						removeButton.className =
							'btn btn-sm btn-outline-danger';


						removeButton.innerHTML =
							'<i class="bi bi-trash"></i>';



						removeButton.addEventListener(
							'click',
							function() {


								removeFile(
									index
								);

							}
						);



						fileBox.appendChild(
							fileInformation
						);


						fileBox.appendChild(
							removeButton
						);


						evidenceContainer.appendChild(
							fileBox
						);

					}
				);

		}



		// -------------------------------------------------
		// REMOVE FILE
		// -------------------------------------------------

		function removeFile(
			indexToRemove
		) {


			const newTransfer =
				new DataTransfer();


			Array.from(
				selectedFiles.files
			)
				.forEach(
					function(
						file,
						index
					) {


						if (
							index !==
							indexToRemove
						) {


							newTransfer.items.add(
								file
							);

						}

					}
				);


			selectedFiles =
				newTransfer;


			displayFiles();

		}



		// -------------------------------------------------
		// FILE SELECTED
		// -------------------------------------------------

		fileInput.addEventListener(
			'change',
			function(event) {


				errorElement.innerHTML =
					'';


				const files =
					Array.from(
						event.target.files
					);


				files.forEach(
					function(file) {


						/*
						 * Get file extension.
						 */
						const nameParts =
							file.name.split('.');


						let extension =
							'';


						if (
							nameParts.length > 1
						) {


							extension =
								nameParts
									.pop()
									.toLowerCase();

						}



						/*
						 * Check extension.
						 */
						if (
							!ALLOWED_EXTENSIONS
								.includes(extension)
						) {


							const error =
								document.createElement(
									'div'
								);


							error.textContent =
								file.name +
								' is not an allowed file type.';


							errorElement.appendChild(
								error
							);


							return;

						}



						/*
						 * Check maximum size.
						 */
						const sizeMB =
							file.size /
							(1024 * 1024);


						if (
							sizeMB >
							MAX_FILE_SIZE_MB
						) {


							const error =
								document.createElement(
									'div'
								);


							error.textContent =
								file.name +
								' exceeds the 100MB limit.';


							errorElement.appendChild(
								error
							);


							return;

						}



						/*
						 * Prevent duplicate files.
						 */
						const duplicate =
							Array.from(
								selectedFiles.files
							)
								.some(
									function(
										existingFile
									) {


										return (

											existingFile.name ===
											file.name &&

											existingFile.size ===
											file.size &&

											existingFile.lastModified ===
											file.lastModified

										);

									}
								);



						if (!duplicate) {


							selectedFiles.items.add(
								file
							);

						}

					}
				);


				displayFiles();


				console.log(
					'Evidence selected:',
					selectedFiles.files
				);

			}
		);

	}



	// =====================================================
	// FORM VALIDATION
	// =====================================================

	function initForm(form) {


		const fields =
			form.querySelectorAll(
				'[data-validate]'
			);


		fields.forEach(
			function(field) {


				field.addEventListener(
					'input',
					function() {


						runValidator(
							field
						);

					}
				);


				field.addEventListener(
					'blur',
					function() {


						runValidator(
							field
						);

					}
				);

			}
		);


		form.addEventListener(
			'submit',
			function(event) {


				let allValid =
					true;


				fields.forEach(
					function(field) {


						if (
							!runValidator(
								field
							)
						) {


							allValid =
								false;

						}

					}
				);


				if (!allValid) {


					event.preventDefault();

					event.stopPropagation();


					const firstInvalid =
						form.querySelector(
							'.is-invalid'
						);


					if (firstInvalid) {


						firstInvalid.focus();

					}

				}

			}
		);

	}



	// =====================================================
	// PAGE LOAD
	// =====================================================

	document.addEventListener(
		'DOMContentLoaded',
		function() {


			document
				.querySelectorAll(
					'form.needs-validation'
				)
				.forEach(
					initForm
				);


			initPasswordStrength();


			/*
			 * Initialize simple evidence selection.
			 */
			initEvidenceSelection();



			/*
			 * Bootstrap tooltips.
			 */
			if (
				typeof bootstrap !==
				'undefined'
			) {


				const tooltipElements =
					document.querySelectorAll(
						'[data-bs-toggle="tooltip"]'
					);


				tooltipElements.forEach(
					function(element) {


						new bootstrap.Tooltip(
							element
						);

					}
				);

			}


			console.log(
				'Validation JavaScript loaded successfully.'
			);

		}
	);


})();