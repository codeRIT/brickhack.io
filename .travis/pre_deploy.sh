eval "$(ssh-agent -s)" # start the ssh agent
openssl aes-256-cbc -K $encrypted_60565ecba2d1_key -iv $encrypted_60565ecba2d1_iv -in marketing_rsa.enc -out marketing_rsa -d --add
