(require 'ox-publish)
(require 'package)
(let* (
	   (file (or load-file-name (buffer-file-name)))
	   (dir (file-name-directory (directory-file-name file)))
	   (package-user-dir (concat dir ".packages"))
	   (package-archives '(
						   ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")  ;;zyt
						   ("elpa" . "https://elpa.gnu.org/packages/")
						   ("org" . "https://orgmode.org/elpa/")
						   ))
	   )
  (package-initialize)
  (unless package-archive-contents
	(package-refresh-contents))
  (package-install 'htmlize)
  (package-install 'simple-httpd)
  ;; Define the publishing project
  (let* (
		 (org-publish-project-alist
		  (list
		   (list "my-org-site"
				 :recursive t
				 :author "zytbit"
				 :email "zytbit@gmail.com"
				 :with-email t
				 :base-directory (concat dir "content")
				 :publishing-directory (concat dir "public")
				 :publishing-function 'org-html-publish-to-html)))
		 org-html-validation-link
		 org-html-head-include-default-style
		 org-html-head-include-default-style
		 (org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
		 (httpd-root (file-name-concat dir "public"))
		 (httpd-port "8080")
		 )
	;; Generate the site output
	(org-publish-all t)
	;; (httpd-start)
	;; ;; (browse-url--browser (concat "http://localhost:" httpd-port)) 
	;; (eww-browse-url (concat "http://localhost:" httpd-port)) 
	)
  )
(message "Build complete!")
