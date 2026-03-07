let count = 0;

function visit() {
    count++;
    document.getElementById("counter").innerText =
        "Button clicked " + count + " times.";
}
