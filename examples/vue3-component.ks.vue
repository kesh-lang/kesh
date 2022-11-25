<!-- original: https://github.com/mutoe/vue3-realworld-example-app/blob/master/src/components/AppLink.vue -->

<template>
  <router-link
    :aria-label="props.name"
    :to="props"
  >
    <slot />
  </router-link>
</template>

<script lang="lua">
import [#AppRouteNames]: 'src/router'
import [#RouteParams]: 'vue-router'

#AppLinkProps:
    name: #AppRouteNames
    params?: #Partial(#RouteParams)

props: with-defaults(define-props(#AppLinkProps)(), [
    params: () -> []
])

[#AppLinkProps]
</script>
