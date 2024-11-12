<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html"%>
<!-- Include Header -->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Home - Cleaning Service</title>
<!-- Custom CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/colour.css" rel="stylesheet">
</head>
<body>
	<main class="container mt-5">
		<!-- Hero Section -->
		<div class="row align-items-center">
			<div class="col-md-6">
				<h1 class="display-1 fw-bold">Expert Cleaning Services You Can
					Trust</h1>
				<p class="lead mb-4">Experience top-quality services tailored to
					your needs for a cleaner, healthier environment.</p>
				<a href="bookService.jsp" class="btn btn-outline-primary btn-lg">Book
					A Service</a>
				<hr class="mt-4 mb-4 w-100">
			</div>
			<div class="col-md-6">
				<img src="../images/cleaning_service_banner.webp" class="img-fluid"
					alt="Cleaning Service">
			</div>
		</div>

		<!-- Statistics Section -->
		<div class="row text-center mt-5">
			<div class="col-md-4">
				<h2 class="display-6 fw-bold">169,000+</h2>
				<p>Customers Served</p>
			</div>
			<div class="col-md-4">
				<h2 class="display-6 fw-bold">420,000+</h2>
				<p>Sessions Completed</p>
			</div>
			<div class="col-md-4">
				<h2 class="display-6 fw-bold">4.89*</h2>
				<p>1,000+ Google Reviews</p>
			</div>
			<hr class="mt-4 mb-4 w-200">
		</div>

		<!-- Service Cards Section -->
		<div class="row mt-5">
			<!-- Sofa Cleaning -->
			<div class="col-md-4 mb-4">
				<div class="card h-100">
					<img src="../images/sofa_cleaning.jpg" class="card-img-top"
						alt="Sofa Cleaning">
					<div class="card-body">
						<h5 class="card-title">SOFA CLEANING</h5>
						<p class="card-text">From S$25/hr</p>
						<a href="#sofaCleaningSection" class="btn btn-outline-primary">Learn
							More</a>
					</div>
				</div>
			</div>

			<!-- Mattress Cleaning -->
			<div class="col-md-4 mb-4">
				<div class="card h-100">
					<img src="../images/mattress_cleaning.jpg" class="card-img-top"
						alt="Mattress Cleaning">
					<div class="card-body">
						<h5 class="card-title">MATTRESS CLEANING</h5>
						<p class="card-text">From S$25/hr</p>
						<a href="#mattressCleaningSection" class="btn btn-outline-primary">Learn
							More</a>
					</div>
				</div>
			</div>

			<!-- Deep Cleaning -->
			<div class="col-md-4 mb-4">
				<div class="card h-100">
					<img src="../images/deep_cleaning.jpg" class="card-img-top"
						alt="Deep Cleaning">
					<div class="card-body">
						<h5 class="card-title">DEEP CLEANING</h5>
						<p class="card-text">From S$70</p>
						<a href="#deepCleaningSection" class="btn btn-outline-primary">Learn
							More</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Additional Services Section -->
		<div class="row mt-4">
			<!-- Aircon Servicing -->
			<div class="col-md-4 mb-4">
				<div class="card h-100">
					<img src="../images/aircon_servicing.jpg" class="card-img-top"
						alt="Aircon Servicing">
					<div class="card-body">
						<h5 class="card-title">AIRCON SERVICING</h5>
						<p class="card-text">From S$320</p>
						<a href="#airconServicingSection" class="btn btn-outline-primary">Learn
							More</a>
					</div>
				</div>
			</div>

			<!-- Plumber -->
			<div class="col-md-4 mb-4">
				<div class="card h-100">
					<img src="../images/plumber.jpg" class="card-img-top" alt="Plumber">
					<div class="card-body">
						<h5 class="card-title">PLUMBER</h5>
						<p class="card-text">From S$15.50/unit</p>
						<a href="#plumberSection" class="btn btn-outline-primary">Learn
							More</a>
					</div>
				</div>
			</div>

			<!-- Electrician -->
			<div class="col-md-4 mb-4">
				<div class="card h-100">
					<img src="../images/electrician.jpg" class="card-img-top"
						alt="Electrician">
					<div class="card-body">
						<h5 class="card-title">ELECTRICIAN</h5>
						<p class="card-text">From S$60</p>
						<a href="#electricianSection" class="btn btn-outline-primary">Learn
							More</a>
					</div>
				</div>
			</div>
		</div>


		<!-- Customer Ratings Section -->
		<div class="row text-center mt-5">
			<!-- Left Column for Google Rating -->
			<div class="col-md-6">
				<h2 class="display-1 fw-bold">4.89* on Google</h2>
			</div>
			<!-- Right Column for "Our customers love us" -->
			<div class="col-md-6">
				<h2 class="display-6 fw-bold">What Our Clients Say</h2>
			</div>
		</div>

		<!-- Customer Feedback Section -->
		<div class="row mt-4">
			<div class="col-md-3">
				<div class="card border-0 h-100 rounded">
					<div class="card-body">
						<blockquote class="blockquote mb-0">
							<footer class="blockquote-footer">
								<cite>Lebron James</cite>
							</footer>
							<p class="fw-bold">★★★★★</p>
							<p>He cooked. I believed he might be the cleaning goat.
								Shoutout to Edward Smiggens</p>
						</blockquote>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<div class="card border-0 h-100 rounded">
					<div class="card-body">
						<blockquote class="blockquote mb-0">
							<footer class="blockquote-footer">
								<cite>Takakura Ken</cite>
							</footer>
							<p class="fw-bold">★★★★★</p>
							<p>I would highly recommend Fugue for busy professionals.
								They clean in mere seconds!!.</p>
						</blockquote>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<div class="card border-0 h-100 rounded">
					<div class="card-body">
						<blockquote class="blockquote mb-0">
							<footer class="blockquote-footer">
								<cite>Toji Fushiguro</cite>
							</footer>
							<p class="fw-bold">★★★★★</p>
							<p>Our cleaner, Loki Alligator, is simply amazing! He cleaned
								very thoroughly every time. I have not seen dust in years!</p>
						</blockquote>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<div class="card border-0 h-100 rounded">
					<div class="card-body">
						<blockquote class="blockquote mb-0">
							<footer class="blockquote-footer">
								<cite>Fireday Flyshine</cite>
							</footer>
							<p class="fw-bold">★★★★★</p>
							<p>I used to have dog odour but not anymore. I owe you one,
								Fugue.</p>
						</blockquote>
					</div>
				</div>
			</div>
		</div>

		<!-- Frequently Asked Questions Section -->
		<div class="container mt-5">
			<h2 class="text-center mb-4">Frequently Asked Questions</h2>
			<div class="accordion" id="faqAccordion">
				<!-- Question 1 -->
				<div class="accordion-item border-0">
					<h2 class="accordion-header" id="headingOne">
						<button class="accordion-button fw-bold" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseOne"
							aria-expanded="true" aria-controls="collapseOne"
							style="background-color: transparent;">What cleaning
							services do you offer?</button>
					</h2>
					<div id="collapseOne" class="accordion-collapse collapse show"
						aria-labelledby="headingOne" data-bs-parent="#faqAccordion">
						<div class="accordion-body fs-5 text-dark fw-semibold">We
							provide a variety of cleaning services, including general
							cleaning, deep cleaning, move-in/move-out cleaning, carpet and
							upholstery cleaning, and more.</div>
					</div>
				</div>

				<!-- Question 2 -->
				<div class="accordion-item border-0">
					<h2 class="accordion-header" id="headingTwo">
						<button class="accordion-button collapsed fw-bold" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseTwo"
							aria-expanded="false" aria-controls="collapseTwo"
							style="background-color: transparent;">How do I schedule
							a cleaning appointment?</button>
					</h2>
					<div id="collapseTwo" class="accordion-collapse collapse"
						aria-labelledby="headingTwo" data-bs-parent="#faqAccordion">
						<div class="accordion-body fs-5 text-dark fw-semibold">You
							can schedule a cleaning appointment through our website or mobile
							app by selecting the service you need and choosing your preferred
							date and time.</div>
					</div>
				</div>

				<!-- Question 3 -->
				<div class="accordion-item border-0">
					<h2 class="accordion-header" id="headingThree">
						<button class="accordion-button collapsed fw-bold" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseThree"
							aria-expanded="false" aria-controls="collapseThree"
							style="background-color: transparent;">Are your cleaners
							insured and background-checked?</button>
					</h2>
					<div id="collapseThree" class="accordion-collapse collapse"
						aria-labelledby="headingThree" data-bs-parent="#faqAccordion">
						<div class="accordion-body fs-5 text-dark fw-semibold">Yes,
							all our cleaners are thoroughly background-checked and insured to
							ensure safety and reliability.</div>
					</div>
				</div>

				<!-- Question 4 -->
				<div class="accordion-item border-0">
					<h2 class="accordion-header" id="headingFour">
						<button class="accordion-button collapsed fw-bold" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseFour"
							aria-expanded="false" aria-controls="collapseFour"
							style="background-color: transparent;">What should I do
							if I need to cancel or reschedule?</button>
					</h2>
					<div id="collapseFour" class="accordion-collapse collapse"
						aria-labelledby="headingFour" data-bs-parent="#faqAccordion">
						<div class="accordion-body fs-5 text-dark fw-semibold">You
							can cancel or reschedule your appointment up to 24 hours before
							the scheduled time without any additional charges.</div>
					</div>
				</div>

				<!-- Question 5 -->
				<div class="accordion-item border-0">
					<h2 class="accordion-header" id="headingFive">
						<button class="accordion-button collapsed fw-bold" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseFive"
							aria-expanded="false" aria-controls="collapseFive"
							style="background-color: transparent;">Do I need to
							provide cleaning supplies?</button>
					</h2>
					<div id="collapseFive" class="accordion-collapse collapse"
						aria-labelledby="headingFive" data-bs-parent="#faqAccordion">
						<div class="accordion-body fs-5 text-dark fw-semibold">Our
							cleaners come equipped with their own cleaning supplies, but if
							you have specific products you would like them to use, please let
							us know in advance.</div>
					</div>
				</div>
			</div>
		</div>

	</main>

	<br>
	<%@ include file="../includes/footer.html"%>
	<!-- Include Footer -->
</body>
</html>
