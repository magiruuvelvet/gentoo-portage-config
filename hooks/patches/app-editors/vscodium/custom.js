document.addEventListener("DOMContentLoaded", () => {

    /**
     * Returns a random number between min (inclusive) and max (exclusive)
     */
    function getRandomArbitrary(min, max) {
        return Math.random() * (max - min) + min;
    }

    /**
     * Returns a random integer between min (inclusive) and max (inclusive).
     * The value is no lower than min (or the next integer greater than min
     * if min isn't an integer) and no greater than max (or the next integer
     * lower than max if max isn't an integer).
     * Using Math.round() will give you a non-uniform distribution!
     */
    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    // create style element
    let style = document.createElement("style");
    style.setAttribute("id", "custom-style");
    document.head.appendChild(style);

    const getCss = (number, index) => {
        return `
            [id="workbench.parts.editor"] .split-view-view:nth-child(${index}) .editor-container .editor-instance > .monaco-editor .overflow-guard > .monaco-scrollable-element::before {
                background-image: url(https://codium-assets.local/resources/app/out/vs/workbench/vscodium-assets/image${number}.png) !important;
            }
            [id="workbench.parts.editor"] .split-view-view:nth-child(${index}) .empty::before {
                background-image: url(https://codium-assets.local/resources/app/out/vs/workbench/vscodium-assets/image${number}.png) !important;
            }
            [id="workbench.parts.editor"] .split-view-view:nth-child(${index}) .editor-container .editor-instance .terminal-overflow-guard .terminal-wrapper::before {
                background-image: url(https://codium-assets.local/resources/app/out/vs/workbench/vscodium-assets/image${number}.png) !important;
            }
        `;
    };

    const shuffleImages = () => {
        let randomNumber = getRandomInt(1, 2);

        let css = "";
        for (let i = 1; i <= 6; ++i)
        {
            css += getCss(getRandomInt(1, 2), i);
        }

        let styleElement = document.getElementById("custom-style");
        styleElement.textContent = css;
    };

    // start shuffling images
    setInterval(shuffleImages, 30000);
    shuffleImages();
});
