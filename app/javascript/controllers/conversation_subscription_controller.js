
import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { conversationId: Number }
  static targets = ["messages", "attachmentPreview", "submitButton", "messageInput", "fileInput"]



  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ConversationChannel", id: this.conversationIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )

    document.addEventListener("input", function (event) {
      if (event.target.tagName.toLowerCase() !== "textarea") return;
      autoResizeTextArea(event.target);
    });
    
    function autoResizeTextArea(textarea) {
      textarea.style.height = "auto";
      textarea.style.height = textarea.scrollHeight + "px";
    }
    
  }


  displayAttachmentPreview(event) {

    const MAX_FILE_SIZE_MB = 3
    const MAX_FILE_SIZE_BYTES = MAX_FILE_SIZE_MB * 1024 * 1024

    const files = Array.from(event.target.files)
    const validFiles = []
    this.attachmentPreviewTarget.innerHTML = ""
  
    files.forEach((file, index) => {
      console.log(file.size)
      if (file.size > MAX_FILE_SIZE_BYTES) {
        alert(`❌ Le fichier "${file.name}" dépasse la taille maximale autorisée de ${MAX_FILE_SIZE_MB} Mo.`)
        return
      }
  
      validFiles.push(file)
  
      const preview = document.createElement("div")
      preview.classList.add("attachment-thumbnail", "position-relative", "d-inline-block", "me-2")
  
      let content
      if (file.type.startsWith("image/")) {
        const img = document.createElement("img")
        img.src = URL.createObjectURL(file)
        img.alt = file.name
        img.style.width = "100px"
        img.style.height = "100px"
        content = img
      } else {
        const container = document.createElement("div")
        container.classList.add("d-flex", "align-items-center", "gap-2")
      
        const icon = document.createElement("div")
        icon.innerHTML = "📄"
        icon.style.fontSize = "40px"
      
        const filename = document.createElement("span")
        filename.textContent = file.name
        filename.style.fontSize = "14px"
        filename.style.wordBreak = "break-word"
      
        container.appendChild(icon)
        container.appendChild(filename)
      
        content = container
      }
  
      const removeButton = document.createElement("button")
      removeButton.type = "button"
      removeButton.classList.add("btn", "btn-sm", "position-absolute", "top-0", "end-0", "bg-white", "rounded-circle")
      removeButton.style.zIndex = 10
      removeButton.style.padding = "0"
      removeButton.style.border = "none"
  
      const removeImg = document.createElement("img")
      removeImg.src = "/assets/icons/false.png"
      removeImg.alt = "Supprimer"
      removeImg.style.width = "24px"
      removeImg.style.height = "24px"
  
      removeButton.appendChild(removeImg)
  
      removeButton.addEventListener("click", () => {
        validFiles.splice(index, 1)
        const dataTransfer = new DataTransfer()
        validFiles.forEach(f => dataTransfer.items.add(f))
        event.target.files = dataTransfer.files
        this.displayAttachmentPreview({ target: event.target })
      })
  
      preview.appendChild(content)
      preview.appendChild(removeButton)
      this.attachmentPreviewTarget.appendChild(preview)
    })
  
    // Rebuild the input's FileList with only valid files
    const dataTransfer = new DataTransfer()
    validFiles.forEach(f => dataTransfer.items.add(f))
    event.target.files = dataTransfer.files
  
    this.updateSubmitButtonState()
  }
  

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    const newMessage = this.messagesTarget.lastElementChild;
    const images = newMessage.querySelectorAll("img");
    console.log("images", images);
    if (images.length > 0) {
      images.forEach(image => {
        image.onload = () => {
          this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
        };
      });
    } else {
      this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
    }
  }

  resetForm(event) {
    event.target.reset()
  
    if (this.hasAttachmentPreviewTarget) {
      this.attachmentPreviewTarget.innerHTML = ""
    }
  
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = true
    }
  }

  validateFormBeforeSubmit(event) {
    console.log("Validate Form Before Submit", event)
    const form = event.target
    const messageInput = form.querySelector("#message_content")
    const attachmentsInput = form.querySelector("#message_attachments")
  
    const hasMessage = messageInput && messageInput.value.trim() !== ""
    const hasAttachments = attachmentsInput && attachmentsInput.files.length > 0
    console.log(messageInput)
    console.log(messageInput.value)
    console.log("Form validation", { hasMessage, hasAttachments })
    if (!hasMessage && !hasAttachments) {
      event.preventDefault()
      // Optionally: give visual feedback or toast
      console.warn("Form submission prevented: no message or attachment")
    }
  }

  updateSubmitButtonState() {
    console.log(this.hasMessageInputTarget)
    console.log(this.messageInputTarget.value)

    const hasMessage = this.hasMessageInputTarget && this.messageInputTarget.value.trim() !== ""
    const hasFiles = this.hasFileInputTarget && this.fileInputTarget.files.length > 0
  
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = !(hasMessage || hasFiles)
    }
  
    console.log("Has targets?", {
      message: this.hasMessageInputTarget,
      file: this.hasFileInputTarget,
      submit: this.hasSubmitButtonTarget
    })
  }

  handleFormSubmit(event) {
    if (this.hasUploadMessageTarget) {
      this.uploadMessageTarget.classList.remove("d-none")
    }
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
