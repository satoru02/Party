<template>
  <div justify="center" align="center">
        <!-- <v-sheet class="name rounded-lg ml-5" color="#212529" width="700"
      style="border: 1px solid hsla(0,0%,100%,.1); height:auto; min-height: 600px; max-width: 100%; max-height:2000px;">
      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-7">
          <h3>Username</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-4">
          <v-text-field v-model="user.username" :placeholder="user.username" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n11">
          <div>Customize your username.</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3>
          <h3>Picture</h3>
        </v-col>
        <v-col cols=12 md=7>
          <form enctype="multipart/form-data">
            <input type="file" ref="inputFile" @change="uploadFile()">
          </form>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>About</h3>
        </v-col>
        <v-col cols=12 md=7 class=mt-n2>
          <v-text-field v-model="user.about" :placeholder="user.about" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n11">
          <div>Who you are in fewer than 300 characters.</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Location</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n2">
          <v-text-field v-model="user.location" :placeholder="user.location" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n11">
          <div>Where you live in.</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Email</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.email" :placeholder="user.email" outlined dark filled dense></v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n11">
          <div>Email you use here.</div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Youtube URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.youtube_url" :placeholder="user.youtube_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Facebook URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.facebook_url" :placeholder="user.facebook_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Instagram URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.instagram_url" :placeholder="user.instagram_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>
      <v-divider></v-divider>
      <v-row>
        <v-col cols=12 md=4></v-col>
        <v-col cols=12 md=7 class="mt-n12">
          <div></div>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=1></v-col>
        <v-col cols=12 md=3 class="mt-1">
          <h3>Filmarks URL</h3>
        </v-col>
        <v-col cols=12 md=7 class="mt-n1">
          <v-text-field v-model="user.filmarks_url" :placeholder="user.filmarks_url" outlined dark filled dense>
          </v-text-field>
        </v-col>
        <v-col cols=12 md=1></v-col>
      </v-row>

      <v-row>
        <v-col cols=12 md=9 class="mt-n16"></v-col>
        <v-col cols=12 md=2 class="ml-n6 mt-n7">
          <v-btn :click="saveProfile()" style="background-color:#2d00f7; font-weight:bold;" dark class="rounded-lg">Save
            Changes</v-btn>
        </v-col>
      </v-row>
    </v-sheet> -->
    </div>
</template>

<script>
export default {
  name: 'IniitalSettings',
  data(){
    return {

    }
  }
}
</script>