<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>

<html>
    <head>
        <title>Performance Statistics</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="../css/profile.css" rel="stylesheet">
        <link href="../css/style.css" rel="stylesheet">
    </head>
    <body class="pale-background">
        <header>
            <outventure:navbar/>
        </header>
        <div class="container">
            <div class="login-container">
                <outventure:profile_left_box currentPage="performance_statistics"/>
                <div class="right-box overflow-auto">
                    <div class="right-box-header">
                        <h3>Your Performance Statistics</h3>
                    </div>
                    <div class="mt-3">
                        <form id="mt-5 performanceStatisticsForm" action="">
                            <div class="card">
                                <div class="card-body">
                                    <p class="form-label">Select your date range</p>
                                    <div class="input-fields-group">
                                        <label for="fromDate"><strong>From:</strong></label>
                                        <input type="date" id="fromDate" name="fromDate">
                                        <label for="toDate" class="ms-3"><strong>To:</strong></label>
                                        <input type="date" id="toDate" name="toDate">
                                    </div>
                                    <div class="d-flex flex-row bd-highlight mb-3">
                                        <div class="p-2 bd-highlight">
                                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="setCurrentMonth()">Current month</button>
                                        </div>
                                        <div class="p-2 bd-highlight">
                                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="setCurrentYear()">Current year</button>
                                        </div>
                                        <div class="p-2 bd-highlight">
                                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="setEntirePeriod()">Entire time period</button>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="d-flex bd-highlight">
                                        <div class="me-auto p-2 bd-highlight">
                                            <p>
                                                <a class="btn btn-secondary" data-bs-toggle="collapse" href="#collapseTutorial" role="button" aria-expanded="false" aria-controls="collapseTutorial">
                                                    Tutorial
                                                </a>
                                            </p>
                                        </div>
                                        <div class="p-2 bd-highlight">
                                            <button type="button" class="btn btn-primary" onclick="resetFilters()">Reset</button>
                                        </div>
                                        <div class="p-2 bd-highlight">
                                            <button type="submit" class="btn btn-success">Apply</button>
                                        </div>
                                    </div>
                                    <div class="collapse" id="collapseTutorial">
                                        <div class="card card-body">
                                            <ul>
                                                <li>
                                                    <strong>Step 1: Set Your Date Range</strong><br>
                                                    Select a specific date range to tailor your stats. Whether it's a recent conquest or a
                                                    trip down memory lane, customize it to fit your journey.
                                                </li>
                                                <li>
                                                    <strong>Step 2: Click "Apply"</strong><br>
                                                    Watch your personalized statistics unfold with a single click. See your completed
                                                    hikes, kilometers covered, altitude conquered, and total duration at a glance.
                                                </li>
                                            </ul>
                                            <p><i>Your Trail, Your Stats, Your Adventure!</i></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="/tagJavaScript/navbar.js"></script>
        <script src="/performance_statistics/performance_statistics.js"></script>
    </body>
</html>
