import {Application} from "@hotwired/stimulus"
import "../stylesheets/application";

const application = Application.start()

application.debug = false
window.Stimulus = application

export {application}
