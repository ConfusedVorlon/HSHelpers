**EXTENSION**

# `CanSendEmail`

## Methods
### `sendByURL(to:subject:body:isHtml:attachments:)`

Send using mailto
- Parameters:
  - to: array of emails
  - subject: subject
  - body: body
  - isHtml: _extremely_ simple html support!
  - attachments: attachments will cause this to fail. They're here to match the system-based call
- Returns: success

### `sendEmail(to:subject:body:isHtml:attachments:)`

Send email with system dialog if available, then with mailto
- Parameters:
  - to: array of emails
  - subject: subject
  - body: body
  - isHtml: _extremely_ simple html support!
  - attachments: attachments only work with the system email

### `sendEmail(to:subject:body:isHtml:)`
