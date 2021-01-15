<template>
  <form class="form-signup" @submit.prevent="saveProfile">
    <!-- <div class="alert alert-danger" v-if="error">{{ error }}</div> -->
    <div class="form-group">
      <label for="email">Email address</label>
      <input v-model="user.email" type="email" class="form-controll" id="email">
    </div>
    <div class="form-group">
      <label for="about">About</label>
      <input v-model="user.about" type="about" class="form-controll" id="about">
    </div>
    <div class="form-group">
      <label for="name">name</label>
      <input v-model="user.name" type="name" class="form-controll" id="name">
    </div>
    <div class="form-group">
      <label for="username">username</label>
      <input v-model="user.username" type="username" class="form-controll" id="username">
    </div>
    <div class="form-group">
      <label for="location">location</label>
      <input v-model="user.location" type="location" class="form-controll" id="location">
    </div>
    <div class="form-group">
      <label for="web_url">website_url</label>
      <input v-model="user.web_url" type="web_url" class="form-controll" id="web_url">
    </div>
    <div class="form-group">
      <label for="youtube_url">youtube_url</label>
      <input v-model="user.youtube_url" type="youtube_url" class="form-controll" id="youtube_url">
    </div>
    <div class="form-group">
      <label for="facebook_url">facebook_url</label>
      <input v-model="user.facebook_url" type="facebook_url" class="form-controll" id="facebook_url">
    </div>
    <div class="form-group">
      <label for="instagram_url">instagram_url</label>
      <input v-model="user.instagram_url" type="instagram_url" class="form-controll" id="instagram_url">
    </div>
    <div class="form-group">
      <label for="filmarks_url">filmarks_url</label>
      <input v-model="user.filmarks_url" type="filmarks_url" class="form-controll" id="filmarks_url">
    </div>

    <div class="example-avatar">
      <div v-show="$refs.upload && $refs.upload.dropActive" class="drop-active">
        <h3>Drop files to upload</h3>
      </div>
      <div class="avatar-upload" v-show="!edit">
        <div class="text-center p-2">
          <label for="avatar">
            <img :src="files.length ? files[0].url : 'https://www.gravatar.com/avatar/default?s=200&r=pg&d=mm'"
              class="rounded-circle" />
            <h4 class="pt-2">or<br />Drop files anywhere to upload</h4>
          </label>
        </div>
        <div class="text-center p-2">
          <file-upload
            v-model="files"
            extensions="gif,jpg,jpeg,png,wedp"
            accept="image/png,image/gif,image/jpeg,image/wedp"
            name="avatar"
            class="btn btn-primary"
            :drop="!edit"
            @input-filter="inputFilter"
            @input-file="inputFile"
            ref="upload">
            Upload Avatar
          </file-upload>
        </div>
      </div>
      <div class="avatar-edit" v-show="files.length && edit">
        <div class="avatar-edit-image" v-if="files.length">
          <img ref="editImage" :src="files[0].url" />
        </div>
        <div class="text-center p-4">
          <button type="button" class="btn btn-secondary" @click.prevent="$refs.upload.clear">Cancel</button>
          <button type="submit" class="btn btn-primary" @click.prevent="editSave">Save</button>
        </div>
      </div>
    </div>
    <button type="submit" class="btn btn-primary mb-3">Save profile</button>
  </form>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios.js'

  import FileUpload from 'vue-upload-component';
  import Cropper from 'cropperjs';

  const USER_URL = '/api/v1/users/'

  export default {
    name: 'Setting',
    data() {
      return {
        user: '',
        files: [],
        avatar: '',
        edit: false,
        cropper: false,
      }
    },
    components: {
      'file-upload': FileUpload
    },
    created() {
      this.checkSignedIn()
    },
    watch: {
      edit(value) {
        if (value) {
          this.$nextTick(function () {
            if (!this.$refs.editImage) {
              return
            }
            let cropper = new Cropper(this.$refs.editImage, {
              aspectRatio: 1 / 1,
              viewMode: 1,
            })
            this.cropper = cropper
          })
        } else {
          if (this.cropper) {
            this.cropper.destroy()
            this.cropper = false
          }
        }
      }
    },
    methods: {
      checkSignedIn() {
        if (this.$store.state.checkSignedIn) {
          this.$router.replace('/')
        }
        this.getUserInformation()
      },
      getUserInformation() {
        simpleAxios.get(USER_URL + `${this.$store.state.currentUser.data.attributes.id}` + `/edit`)
          .then(response => this.fetchSuccessful(response))
          .catch(error => this.Failed(error))
      },
      fetchSuccessful(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.user = response.data.data.attributes
      },
      saveProfile() {
        secureAxios.defaults.headers.common['X-CSRF-TOKEN'] = this.$store.state.csrf
        secureAxios.patch(USER_URL + `${this.$store.state.currentUser.data.attributes.id}`, {
            email: this.user.email,
            about: this.user.about,
            name: this.user.name,
            username: this.user.username,
            location: this.user.location,
            web_url: this.user.web_url,
            youtube_url: this.user.youtube_url,
            facebook_url: this.user.facebook_url,
            instagram_url: this.user.instagram_url,
            filmarks_url: this.user.filmarks_url,
            avatar: this.avatar
          })
          .then(response => this.updateSuccessdul(response))
          .catch(error => this.Failed(error))
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      updateSuccessdul(response) {
        if (!response.data) {
          this.Failed(response)
          return
        }
        this.$router.replace('/setting')
      },
      editSave() {
        this.edit = false
        let oldFile = this.files[0]
        this.avatar = oldFile.url
        let binStr = atob(this.cropper.getCroppedCanvas().toDataURL(oldFile.type).split(',')[1])
        let arr = new Uint8Array(binStr.length)
        for (let i = 0; i < binStr.length; i++) {
          arr[i] = binStr.charCodeAt(i)
        }
        let file = new File([arr], oldFile.name, {
          type: oldFile.type
        })

        this.$refs.upload.update(oldFile.id, {
          file,
          type: file.type,
          size: file.size,
          active: true,
        })
      },
      inputFile(newFile, oldFile, pervent) {
        if (newFile && !oldFile) {
          this.$nextTick(function () {
            this.edit = true
          })
        }
        if (!newFile && oldFile) {
          this.edit = false
        }
      },
      inputFilter(newFile, oldFile, prevent) {
        if (newFile && !oldFile) {
          if (!/\.(gif|jpg|jpeg|png|webp)$/i.test(newFile.name)) {
            this.alert('Your choice is not a picture')
            return prevent()
          }
        }
        if (newFile && (!oldFile || newFile.file !== oldFile.file)) {
          newFile.url = ''
          let URL = window.URL || window.webkitURL
          if (URL && URL.createObjectURL) {
            newFile.url = URL.createObjectURL(newFile.file)
          }
        }
      },
      alert(message) {
        alert(message)
      },
    }
  }
</script>

<style>
  input {
    color: white;
    font-family: 'Open Sans', sans-serif;
    font-size: 20;
    font-weight: bold;
  }

  .example-avatar .avatar-upload .rounded-circle {
    width: 200px;
    height: 200px;
  }

  .example-avatar .text-center .btn {
    margin: 0 .5rem
  }

  .example-avatar .avatar-edit-image {
    max-width: 100%
  }

  .example-avatar .drop-active {
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
    position: fixed;
    z-index: 9999;
    opacity: .6;
    text-align: center;
    background: #000;
  }

  .example-avatar .drop-active h3 {
    margin: -.5em 0 0;
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    -webkit-transform: translateY(-50%);
    -ms-transform: translateY(-50%);
    transform: translateY(-50%);
    font-size: 40px;
    color: #fff;
    padding: 0;
  }
</style>