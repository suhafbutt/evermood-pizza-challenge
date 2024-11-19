import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

console.log('asdasdasdasd');

export { application }


{/* <script>
Turbo.setProgressBarDelay(0);
document.addEventListener("turbo:submit-start", (event) => {
  console.log("Turbo request started:", event.detail);
});
document.addEventListener("turbo:submit-end", (event) => {
  console.log("Turbo request ended:", event.detail);
});

</script> */}