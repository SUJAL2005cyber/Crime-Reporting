<%@ page language="java"
	contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setAttribute("pageTitle", "Admin Login");
%>

<jsp:include page="header.jsp" />

<section class="auth-wrapper">

	<div class="container-fluid p-0">

		<div class="row g-0 h-100">


			<div class="col-lg-5 auth-side"
				style="background: linear-gradient(160deg, #12233d, var(--navy-950));">


				<i
					class="
                    bi
                    bi-shield-lock-fill
                    fs-1
                    mb-3"
					style="color: var(--gold-500);"> </i>


				<h2 style="color: #fff;">Officer Admin Access</h2>


				<p class="text-white-50">Restricted area. Manage incoming
					reports, assign investigations, and update case status for the
					jurisdiction.</p>


				<div
					class="
                        d-flex
                        align-items-center
                        gap-2
                        mt-4
                        p-3
                        rounded-3
                    "
					style="background: rgba(255, 255, 255, 0.06);">


					<i
						class="
                        bi
                        bi-info-circle
                        text-white-50">
					</i> <span
						class="
                            small
                            text-white-50
                        ">

						Unauthorized access attempts are logged. </span>

				</div>

			</div>



			<div
				class="
                    col-lg-7
                    auth-form-side
                    d-flex
                    align-items-center
                ">


				<div class="w-100 mx-auto" style="max-width: 420px;">


					<div
						class="
                            d-flex
                            align-items-center
                            gap-2
                            mb-3
                        ">


						<span
							class="
                                badge
                                rounded-pill
                            "
							style="background: var(--gold-100); color: var(--navy-800);">


							<i
							class="
                                bi
                                bi-shield-lock">
						</i> Admin Portal

						</span>

					</div>



					<h3 class="mb-1">Admin Login</h3>


					<p
						class="
                            text-muted-custom
                            mb-4
                        ">

						Sign in with your officer credentials.</p>



					<c:if
						test="${
                            not empty
                            errorMessage
                        }">


						<div
							class="
                                alert
                                alert-danger
                            ">


							<i
								class="
                                bi
                                bi-exclamation-triangle
                            ">
							</i>


							<c:out
								value="${
                                    errorMessage
                                }" />


						</div>

					</c:if>



					<form
						action="${
                            pageContext
                            .request
                            .contextPath
                        }/AdminLoginServlet"
						method="post">


						<div class="mb-3">


							<label for="username" class="form-label"> Username </label> <input
								type="text" class="form-control" id="username" name="username"
								value="${
                                    username
                                }"
								required>


						</div>



						<div class="mb-4">


							<label for="password" class="form-label"> Password </label> <input
								type="password" class="form-control" id="password"
								name="password" required>


						</div>



						<button type="submit"
							class="
                                btn
                                btn-gold
                                w-100
                                py-2
                            ">


							<i
								class="
                                bi
                                bi-shield-lock">
							</i> Secure Login


						</button>


						<p
							class="
                                text-center
                                small
                                mt-3
                                mb-0
                            ">


							<a
								href="${
                                    pageContext
                                    .request
                                    .contextPath
                                }/login.jsp">


								<i
								class="
                                    bi
                                    bi-arrow-left">
							</i> Back to citizen login


							</a>

						</p>


					</form>


				</div>

			</div>

		</div>

	</div>

</section>


<%@ include file="footer.jsp"%>