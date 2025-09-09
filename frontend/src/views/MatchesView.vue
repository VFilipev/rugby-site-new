<template>
  <div class="matches-view">
    <MatchCarousel />
  </div>
</template>

<script>
import MatchCarousel from '@/components/MatchCarousel.vue'

export default {
  name: 'MatchesView',
  components: {
    MatchCarousel
  }
}
</script>

<style scoped>
.matches-view {
  width: 100%;
  min-height: 100vh;
}
</style>
