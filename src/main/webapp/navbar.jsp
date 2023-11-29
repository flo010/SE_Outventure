<%--
  Created by IntelliJ IDEA.
  User: Lea Roncero
  Date: 07.11.2023
  Time: 09:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">
                    <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAWC0lEQVR4nO3deYyc9X3H8XdGq9XKslaWa22RYyHXtZBFqeVaLnFdN6EOJa5LaEQS2tDcJeSilKZtmkMJcimKKEWU0txNkzShlFCSEnJRcrWGcuRqSNIEguNwOTg4xuY0mN1P//juxPbu7Ozze+Z55pnZ3+cl/WSO9TPPzM7zeX738wxJmFmeWk2fgJk1xwFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgFnGHABmGXMAmGXMAWCWMQeAWcYcAGYZcwCYZcwBYJYxB4BZxhwAZhlzAJhlzAFgljEHgC1UY8BpwNqmT2SQOQBsoVkGvA34IXAtcBPwUvxd7+gZkpo+B7MqLAX+FDgXWDLj/x0EXgX8W79PatA5AGwh2Aa8H1jR5WceBf4A+FxfzmhIOABs2G0DrgTGC/zsXuD5wC21ntEQcQDYMFsC7ABOSPg7PwaeC/yojhMaNu4YsWF2FnB84t9ZCXyM2f0EWXIA2LA6EfhLyn2HNwEXAaOVntEQchPAhkkL2AC8GHg10fNf1hTwGuCfKzivoeUAsGFwLDGW/zJgTYXH3Qf8NnB7hcccKg4AG1QjwCnAa4Gt1Fdd/wLwQuDxmo4/0BwANmgWE9X7NwLH9eH1poCXAJ/ow2sNHAeADYpFwCuBt9J9Qk8dbgeeA+zv8+s2zqMANgg2ATcD76b/Fz/EgqEsRwUcANakFjF3/waaX7V3FvAXRN9DNtwEsKaMAOcDb2Zw7rxTwPuI+QVZdAo6AKwJY8AlwOsYzFroLcAfA//X9InUbRA/fFvYJoArGNyLH2AjsY/AuSzwJoFrANYvY8CZwHaa6egr64tEbeCepk+kDg6A/msRQ16PNn0ifXIMceG/Hljd8LmUdR8xV+DGpk+kaoNaBVuIxoCXA98CHiQmuyxUK4Czgc8DdxPt/WG9+CHez+dZgFuLuQZQv1HiDvh2jr4IfgD8JjEffdgtIsbynwecTKzPX4ht5yngb4ALgKcbPpdKOADq0yLmsr8LWDfHzzxM7FO3Hdjdp/Oqyhri/f0usJmYwjtIHiA2/TiR6sPoA8T+gwcrPm7fOQDqsQq4GHgBxaqMDxAz0T7J4HY2jREX+vOJbbhWMdjV4c8Qi3y2AZdTfcfjp4FXMOTThx0A1VoEnENU94vsUdfJXqJ58CngH4Gnqjm10pYBbyA68Y7p4+vuIz7HpcSEodTJQv8K/NH0Px8LXE3UBqr0VWKj0Z9WfNy+cQBUZx3wXmIMuQpTRPPgHTSzf90oMT32HfT3woeYhfcS4i47Sly8pyUe4z+IjUPabfVlxFZgWys6x7ZbgN9nSENgkKtww2IUOI/YnLKqix/id3Mm8D3gKmB9hceezwbgS8TinH5f/BB3/M9M//NTRB9JamfpGEe3/fcSofKFns/uaBuJtQzDNLfh5xwAvVlB3J0upb5OsDHgDGJm2sWUb1oUMU70RfwX0d5vwr8D7yFqQG3fJP2hHouZ3fm3n3pCYC0xTLiq4uPWzk2AclrAi4DL6P8d8kai86nqZsFG4uEaTa7Ku4vYsrtTR+hqopZV9PO+D3gWnUdXlgDXAFtKnGM3dwK/R7yPoeAawGxjxHz1Fcy+q7eI8e5riWp5E9XjzcD1VHuhvrTkMZ8GbgP+muhwezFxBy/jcWJoba5RkLtI27VnBTEE26nGtJ/ovLst5QQLOI5oOs017Dt4JLlILUnbJF0r6REd7UlJeyTtkvSQBsfdkjaq9/e+RtK9ia/9pKT3SlrV4XinlXw/F0kamedcT5D0YOJx75Z0tqRFHY63QtJ3Sp5vN3skbe7wegNXGj+BAShrJd3Q+fc48PZIOlnl3/tiSZ9PfM17JW3tcswLSryPmyUtLXjOHypxfEn6yfS5HTvjeMdJ2lnymN0ckHSqyv9u+lJy7gMYJcbsLyDG74fVfmK12icT/16L6F1/G8WbgrcT1fw75/j/40Q7PaUpsY9oNxd9Xt8Gote97JN9DhKf1SVE5yLEPIHTgN8g5gpUNcnpIPAnxLMHpub52WY0nUANlWWSrpkzu4fPY5LO1fxV6CPLGdN/r6hvS1o5zzFPUzQPUrwp4ZzbZYukqyU9kfhaRzok6QpFDaDT9+NUSZcomgiTPbzOpKJ5M9rhdRovjZ9AA+V41dPua9ohSZepc1t3ZtmoaD4U9X1Jq+c55oik6xLP+VMFz3euskLSOxX9M2U9prjQx7u8zjpJ79bs/qEUNyjOt+nv/1Gl8RPoc9mqtC/+MPqspOXqftF8L+F49ysugPk+202Kdm9RO9W5E7FMGZV0uqSvKIKwjDsUNYtur3OMpMuVXstpu1+99dlUXho/gT6VEUmvU29VxmGyU9JJmv05LFaMdBR1QDE6Mt/n25J0ZcJxHyt43DJlo6RbE87lSE8oRgxa87zGekk7VK5pcEjSdkljCe+ptpLDPIBR4EJiWutYg+fxNPFs+v8kdp79e+AfiDnrVc8jXwVcx9E77raIKbZF59Q/ReyO+7kCP7uRtDn2F1H9bLy2fZTvcBsj1nPMt/jom8SDRF5DrORMMQK8E7iVmFPSrKYTqOayWNHR04QnJd2kSPuTps+l2x10vWJsPaUaXcQOxd321Sre6Tcp6V0q1qk4pmh2FHWVemv3dyur1Vt/wJGuULGhyWWS3q9yTY9DiibFkgKvU0tp+gKts0xI+lLx30Vl9ijGm1cmnm+7LJ3++1UHQYqiF+kixRe4aFX4JsUFU8fve6liPkGVfqhos8/XJEDRB/K1kq+zS9IpBV6j8tL0RVpXWa0Ytuqn9uy4qr7gqxR3obKdWmXdrAjP+c5vreKCLuobmj0Jp6rSkvTBcm93XpOSPlrw3EckvVIx+7DM61ymPvcNNH2h1lE2qNwvoBc/U4yr1/HFPlX1zFTrZKdianC3c1ok6S1Kq6HUefG3P6eT1PvcgG4eUYznF2kWLFYMT5apxV2v7s3FSkvTF2vVZaviYuynPZp/+KjXMqG4C9VZG3iowPvYrPQe9s8qhs/69R2YUPR3XKWY/lu1n0h6g4pN7Fmu6B9IHTbcoWK1sJ7LQpkK3CJWtL2f/vb07yb2nSs6jbUXLeB0YjRjouJjHwTeSExZ7WSCmDb8Sop/vk8Roxzn09xz9lrENN810+WXgZXA8ukyQfkpv/8DvIq5p0UfaTXx+Z1B8Q1K7yR2GvpBqbMraCEEwAjxVNcL6e/y5oeJi/+LfXxNiCWnH6K6DTumgL8l9t+bOXw2QgTrhcQFU9QPiDnw/f5sUo0Ry4aPJZZ2HwM8c/rPFcy9LLztAWKT1K8XfL3jgLcCf0ixIN1LfMf+u+Dxkw17AIwRu+ScU/Lv30MscNlK2tbRTwF/Ruxc04RFxJ31XHqv8XyCuJPNvEuvJRbMbKF4sD5K3PUvZsh3y51hnAiFCWJvwWXT//wLwNdI363oWOL782rm3+HpcSIE6pk30Y92Rk1lXNHpU8YexczAMUWv/a7Ev/9eFRsaqrucot46CL+k2Z1aY5LerLQOrEOKxVWdFta4dP8On63oJO02lHpA0bld+Tk0/QGULccoOkpSTSoWoBy5KGOr0qZ03qH+dmrNV1ap3OSXb2n24pTVivn0KW5WdB4OQiAOc9msWDA013dxl4rvmVC4DONU4Pa2S6lt4H3E1M0XEvvFQVTlLqJ4FfcgsU126vTPOm0krX0OsZ/gSzj8OUA8QGMHcFLBY9xJbAP2W8CXGdT17sPjRuB3iO9opx2QVxJTs6s1AMmXUjYpVlSl2qHZ1dMxpS1gkaKaO0h3us1K3yLrXh1dnWxJOkvFpwnvUazh79tYdYZlvToPZx9Q95WeyaXpN5pSXqD0iRVPKua0z5xdNab0raV+pmLLYvtV1im96n+vpBNnHOccFZs884iki1XfVF6Xo8vJ6hzKl6rCm1DTb7JIaSm+pKmTKe5X5yWnixSTalJd2of3WrRsVPpsx04X/zbNH6rtfpP5Zgi6VF8u0Ow+gcdU3T4KAx8Ao4q7Tkon3aSid7vT7ivLFFMtU+1UxVWvHso2pW9qskuzL/4inYd3KKYiD1KzJ6eyaPp3MNOVVf1Omn6D3UqZYb4nNff+aycobSecticknVnzey1S2m311G2pvqPYBu3IY42qe//HE4rg7bZNlkt/yhmaPQV8UhVtO970m5urLFfaSjMp2uinz3G8bUrvLGu7Ws3fAccU1cHUZtBN6lwTOqPLsb6vzrsJuTRTWuq8zPlWVbDRaNNvrlM5QbEOO8U31LmNOiLpPJXfw22n6l3FVqQsUfpohRRbf3UaN16qudetX6M+LUJxSSqnqPNCsPN6PXbTb6zTG025Ux+S9GF1rqouVm9rxB9RffvWFS2rlL7JxSHFTMW5hunO1uw+lUnFrrd17dTjkl5aij0XzlMEdqd+sAOaf7fmrmVQ1gK0iGfRX0bxue2PExMjOs3HXwlcQfk91/YTEzLKPueuCluAj5L22OlHicUm7yP2IJxpGTGJauaDOz4CvJ6Y6GT9txw4Ybr8CrFycS3Fnjj9deKBqg+XeuUBSLpRRcddSk//TsWkoE7HO1nlJgu1TSrmwjf1eYwohj1TO/vu1fzr+Tvd/VMey+VSTVk9/bu4UunPZezkGpXsD2j6gxhX2hN6JhXPsus0F39EsVNN2fZ+27fU3Cy3cUWzJXW76R2avyq4TLO3SXtIQ/IQywVQjldsEPtt9fakoblcpbQnQyEpaQls1VYBVwPrC/78U8DfEctgZ1ZvJ4jNQF7Q4zkdJB4p/WiPxyljLfBhin8ecHjTje3Mf86nElXMI32A2NjC6rGU2E/hFcQjw+tce3PG9PFfQcoGLA2l4Walbdf0oOK5c52OtUnpowZzuUn9f4ZbS9LLlb6V2d0q/vTZcc3eyutr8rTeusoqxW7JTezsfKsSHkHW7w+mpbT96dtvqFP1dlRR5S+6CeSkor17ljrvGPyE+t/rv1QxipE60/E6pT1n7nQdPYz0kDzWX9fv8xKlfb/r8BMVbNr188MZU9oe8u3hrE5DUynr1g8p5rK3P5BxdR4H/5j6O+Fns2LSTYoHFQGW0tYbVfSbtE1Kelsf32cuZbXSf591elLxXel63v36cI5R2kYTByS9tMNxlihW9xVJ2McUO7LOnCA0oaNHCQ4p7qj9mgCzWNKFBd9D26RiYs/KEq+3XkdXRa+Vx/vrKBeqns69Xl2uLjeMfswD2EB09q0s+PO3ExtNfHfGf99MjO0fO8/f3wf8EzGnYHeH/78auIPoMPkx8FrieX39sJnY1XfmOHw3DwB/BXyccptuvInY2w/i/T6X2BDEqtXi8I7D7c718ekyAfwiMaejvQnpCtL2oezFl4mNcGbt01jnCbSAM4mHLRaZ0DAF/Auxm+zMHu3TgY8Rm2HO9Xe/S4wEfJzukyLaE2s+TUz2qfrBnJ2sJEYvzqT7QyePdJDYpns75c+xRTzEEmLE4O344q/LFPHZFv18R4jvxarpP3+Jw1uVLyZGEFZT/PvSzRZit6ffIzbCPWyuqkGPZZHSpuEeUDxSqdOxNqpzR99DimW/25W2YeIJitV9dbf3RyQ9WzHZI+VpNZOK5lIVm0COK9ZJSPGYseRxYpdGy2JFp/kuVeNexff/569RRxNgDVFVLzqe/b/Ay5hd5W8bJ8avR4nxzb3TpdzUx3q1iPf/IqIZc1zi3/8RsefgJ+g8lTfVMuArxGf4XOCuCo5p/TdO7F15Fr3X2vcRNYFboPrnArwI+CCwpMDPThETUf6c5p4cU4VRop/j+cBpwPEljnEfMQHpI1T7WUwQc//fTawPsOG2CbictMlinewHngfcVlUALCYeBnE2xWY77SUWnzS52KasFtE2ezaxi+sW4k5bxgPE5/YB6pl9OAFcQCyaGsQak5WzmZhZ+EyiD2H1dJnvISNH2g88p4oA2EB00K0p8LNTRI/7a5nZGTG4RogmyCZiC+zNpK3Q6+RHxCjFR6j3wlxM1Mbum+8HbUFYQYwwrQF+lfjermbuGvn5vQRA+5l82ynWU9leqvoeBncP+VHiw1sP/BoRbkWXZc5niujvuJSo+XjprfXLUmLocTlH11ZvKRsAxxNt/aLr7W8khtxqfdJponbn4lriYl83/e9zDTWW9TBxwX8QuI3BDT/LUGqP4igxlvwWit/1zydWrFXRq11G+xHR6zh8sa8lxl7rWp11kHii69XAJ+n8pBezxqUEwBai3TpzSWknU8DniEk9P04/rdLas7E2AL9OVOXXEVWguv0U+CpwPfAZ+jPByKwnRQJgNdFTXWSt/RQxvng+/Xk2/FLi2XjPAk4kLvyyPfIp2rO+vgncTFz4t+PqvQ2ZbgGwlOi0O4fu+/RNERfCNUR1987Kzm625URN5DlE/8Ma6t1kYYoYrbiL6L+4g5iwdDuu1tsC0CkARoDXEXfxue6mjxN3veuI6m7dw0xbiNGGTVR7wR8kzn33EX/uIpot9xB3+WGepGTW1cwA2EQsqOnUzv8uMYZ/PdHB1Y9hrBHgPGKWXEp/xUGiDb57xp/3E5NvdhMX+F5cbbeMtS+qUeIiO4/Dd9jdxDLCG6b/7PdkkhHgQuDNR/y3p4kL+B4OX8j3T//77un/9lNcPTcr5BmSJojhqqXEOPUOYty+6YUj7am23+dwlfwBmhtONFtwBuXBIGbWgDp70M1swDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDLmADDLmAPALGMOALOMOQDMMuYAMMuYA8AsYw4As4w5AMwy5gAwy5gDwCxjDgCzjDkAzDL2/yQ1EapZREuMAAAAAElFTkSuQmCC" width="256" height="256" alt="Outventure Logo">
                    Outventure
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <form class="d-flex align-items-center form-search" style="padding-right:150px">
                            <div class="input-group">
                                <button class="btn btn-light dropdown-toggle shadow-0" type="button" data-mdb-toggle="dropdown"
                                        aria-expanded="false" style="padding-bottom: 0.4rem;">
                                    All
                                </button>
                                <ul class="dropdown-menu dropdown-menu-dark fa-ul">
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i class="fas fa-search"></i></span>All</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i
                                                class="fas fa-film"></i></span>Titles</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i class="fas fa-tv"></i></span>TV
                                            Episodes</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i
                                                class="fas fa-user-friends"></i></span>Celebs</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i
                                                class="fas fa-building"></i></span>Companies</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i
                                                class="fas fa-key"></i></span>Keywords</a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider" />
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#"><span class="fa-li pe-2"><i
                                                class="fas fa-search-plus"></i></span>Advanced
                                            search<i class="fas fa-chevron-right ps-2"></i></a>
                                    </li>
                                </ul>
                                <input type="search" class="form-control" placeholder="Search" aria-label="Search" style="width:500px; max-width:500px "/>
                            </div>
                            <a href="search_results" class="text-white"><i class="fas fa-search ps-3"></i></a>
                        </form>
                        <a class="nav-link" href="search_results">Search Hike</a>
                        <a class="nav-link" href="create_hike.jsp">Create Hike</a>
                        </ul>
                    </div>
                </div>
                <div class="navbar-nav">
                    <a class="nav-link" href="profile.jsp">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="white" class="bi bi-person-fill" viewBox="0 0 16 16">
                            <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                        </svg>
                        Profile
                    </a>
                </div>

            </div>
        </nav>

    </body>

</html>
