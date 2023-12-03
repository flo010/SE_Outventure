<%--
  Created by IntelliJ IDEA.
  User: flo01
  Date: 01/12/2023
  Time: 23:25
  To change this template use File | Settings | File Templates.
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="min" required="true" type="java.lang.Integer" %>
<%@ attribute name="max" required="true" type="java.lang.Integer" %>
<link href="../../search_results/filter.css" rel="stylesheet">

<div
        class="row border border-2 rounded text-center px-1 pt-1 pb-2 g-1"
        id="${name}"
>
    <div>
        <div class="">
            <div>
                <input class="but" id="${name}Switch" type="checkbox" />
                <label class="simp" for="${name}Switch">
                    ${name}
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="16"
                            height="16"
                            fill="currentColor"
                            class="bi bi-arrow-down"
                            viewBox="0 0 16 16"
                            id="${name}ArrowDown"
                    >
                        <path
                                fill-rule="evenodd"
                                d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1"
                        />
                    </svg>
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="16"
                            height="16"
                            fill="currentColor"
                            class="bi bi-arrow-up"
                            viewBox="0 0 16 16"
                            style="display: none"
                            id="${name}ArrowUp"
                    >
                        <path
                                fill-rule="evenodd"
                                d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"
                        />
                    </svg>
                </label>
            </div>
            <div slider id="slider-${name}" style="display: none">
                <div>
                    <div inverse-left style="width: 100%"></div>
                    <div inverse-right style="width: 100%"></div>
                    <div range style="left: 00%; right: 0%"></div>
                    <span thumb style="left: 0%"></span>
                    <span thumb style="left: 100%"></span>
                    <div sign style="left: 0%">
                        <span>${min}</span>
                    </div>
                    <div sign style="left: 100%">
                        <span>${max}</span>
                    </div>
                </div>
                <input
                        id="${name}Low"
                        type="range"
                        tabindex="0"
                        value="1"
                        max="${max}"
                        min="${min}"
                        step="1"
                        oninput="
                this.value=Math.min(this.value,this.parentNode.childNodes[5].value-1);
                var value=(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.value)-(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.min);
                var children = this.parentNode.childNodes[1].childNodes;
                children[1].style.width=value+'%';
                children[5].style.left=value+'%';
                children[7].style.left=value+'%';children[11].style.left=value+'%';
                children[11].childNodes[1].innerHTML=this.value;"
                />
                <input
                        id="${name}High"
                        type="range"
                        tabindex="0"
                        value="5"
                        max="${max}"
                        min="${min}"
                        step="1"
                        oninput="
                this.value=Math.max(this.value,this.parentNode.childNodes[3].value-(-1));
                var value=(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.value)-(100/(parseInt(this.max)-parseInt(this.min)))*parseInt(this.min);
                var children = this.parentNode.childNodes[1].childNodes;
                children[3].style.width=(100-value)+'%';
                children[5].style.right=(100-value)+'%';
                children[9].style.left=value+'%';children[13].style.left=value+'%';
                children[13].childNodes[1].innerHTML=this.value;"
                />
            </div>
        </div>
    </div>
</div>

<script>
    // Get references to the checkbox and the content div
    const ${name}Switch = document.getElementById("${name}Switch");
    const ${name}contentToHide = document.getElementById("slider-${name}");
    const ${name}arrowDown = document.getElementById("${name}ArrowDown");
    const ${name}arrowUp = document.getElementById("${name}ArrowUp");

    // Add event listener to checkbox to toggle visibility of the content
    ${name}Switch.addEventListener("change", function () {
        if (this.checked) {
            ${name}contentToHide.style.display = ""; // Hide the content
            ${name}arrowUp.style.display = "";
            ${name}arrowDown.style.display = "none";
        } else {
            ${name}contentToHide.style.display = "none"; // Show the content
            ${name}arrowUp.style.display = "none";
            ${name}arrowDown.style.display = "";
        }
    });
</script>
