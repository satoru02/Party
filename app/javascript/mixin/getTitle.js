function getTitle(vm){
  const { title } = vm.$options
  console.log(vm)
}

export default {
  created(){
    const title = getTitle(this)
  }
}