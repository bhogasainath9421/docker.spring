def call() {
sh 'docker build -t ${IMAGE_NAME} .'
}
