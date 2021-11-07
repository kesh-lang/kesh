<!-- original: https://github.com/mutoe/vue3-realworld-example-app/blob/master/src/components/AppLink.vue -->

<template>
  <router-link
    :aria-label="props.name"
    :to="props"
    v-bind="attrs"
  >
    <slot />
  </router-link>
</template>

<script lang="lua">
import [#AppRouteNames]: 'src/router'
import [defineComponent, #PropType]: 'vue'
import [#RouteParams]: 'vue-router'
import [RouterLink]: 'vue-router'

default: defineComponent [
    name: 'AppLink'
    components: [RouterLink]
    props:
        name:
            type: String#PropType(#AppRouteNames)
            required: true
        params:
            type: Object#PropType(#RouteParams)
            default: () -> []
    setup: (props, [attrs]) -> [props, attrs]
]

[default]
</script>
