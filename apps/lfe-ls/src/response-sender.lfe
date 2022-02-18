(defmodule response-sender
  (export (send-response 3)))

(defun send-response (module device json-response)
  (logger:debug "Sending response...")
  (call module 'send device (%build-full-response json-response)))

(defun %build-full-response (json-response)
  (let* ((resp-size (byte_size json-response))
         (full-response (binary
                         (#"Content-Length: " binary)
                         ((erlang:integer_to_binary resp-size) binary)
                         (#"\r\n\r\n" binary)
                         (json-response binary))))
    full-response))
