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

    const shuffleImages = () => {
        let randomNumber = getRandomInt(1, 2);

        let css = `
            @keyframes background_image_fade {
                0% {
                    opacity: 0;
                }
                50% {
                    opacity: 1;
                }
                100% {
                    opacity: 1;
                }
            }

            [id="workbench.parts.editor"] .split-view-view .editor-container .editor-instance > .monaco-editor .overflow-guard > .monaco-scrollable-element::before {
                background-image: url(file:///opt/vscodium-assets/image${randomNumber}.png) !important;
            }
            [id="workbench.parts.editor"] .split-view-view .empty::before {
                background-image: url(file:///opt/vscodium-assets/image${randomNumber}.png) !important;
            }
        `;
        let styleElement = document.getElementById("custom-style");
        styleElement.innerText = css;

        setTimeout(shuffleImages, 30000);
    };

    shuffleImages();
});
