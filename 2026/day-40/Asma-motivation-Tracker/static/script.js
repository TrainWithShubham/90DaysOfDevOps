console.log("Asma Motivation Tracker Loaded 🚀");

document.addEventListener("DOMContentLoaded", () => {

    const quoteBox = document.querySelector(".quote");

    const extraQuotes = [
        "Success is built one day at a time.",
        "Consistency beats motivation.",
        "Future DevOps Engineer Loading...",
        "Small progress is still progress.",
        "Stay disciplined and trust the process."
    ];

    // Change motivational quote every 5 seconds
    setInterval(() => {
        const randomQuote =
            extraQuotes[Math.floor(Math.random() * extraQuotes.length)];

        if (quoteBox) {
            quoteBox.innerText = `"${randomQuote}"`;
        }
    }, 5000);


    // Progress color logic
    const progressInputs = document.querySelectorAll(
        'input[name="progress"]'
    );

    progressInputs.forEach((input) => {

        input.addEventListener("input", () => {

            const value = parseInt(input.value);

            if (value >= 80) {
                input.style.border = "2px solid green";
            }
            else if (value >= 40) {
                input.style.border = "2px solid orange";
            }
            else {
                input.style.border = "2px solid red";
            }
        });

    });

});