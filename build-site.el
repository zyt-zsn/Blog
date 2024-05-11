(require 'ox-publish)
(require 'package)
(require 'files)
;; Define the publishing project
(let* (
	   (file (buffer-file-name))
	   (dir (file-name-parent-directory file))
	   (package-user-dir (concat dir ".packages"))
	   (org-publish-project-alist
		(list
		 (list "my-org-site"
			   :recursive t
			   :author "zytbit"
			   :email "zytbit@gmail.com"
			   :with-email t
			   :base-directory (file-name-concat dir "content")
			   :publishing-directory (file-name-concat dir "public")
			   :publishing-function 'org-html-publish-to-html)))
	   org-html-validation-link
	   org-html-head-include-default-style
	   org-html-head-include-default-style
	   (org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
	   (httpd-root (file-name-concat dir "public"))
	   (httpd-port "8080")
	   )
  (package-initialize)
  (unless package-archive-contents
	(package-refresh-contents))
  (package-install 'htmlize)
  (package-install 'simple-httpd)
  ;; Generate the site output
  (org-publish-all t)
  (httpd-start)
  ;; (browse-url--browser (concat "http://localhost:" httpd-port)) 
  (eww-browse-url (concat "http://localhost:" httpd-port)) 
  )
(message "Build complete!")
