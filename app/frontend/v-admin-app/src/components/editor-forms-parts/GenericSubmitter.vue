<template>
  <div
    v-if="forceShow || hasPendingChanges"
    class="q-gutter-md generic-submit-cont"
    xs12
    sm12
    offset-sm0
  >
    <q-btn @click="runModelUpdate" color="primary" type="submit"> Save </q-btn>
    <q-btn @click="runCancelListingChanges">Cancel</q-btn>
  </div>
</template>
<script>
// import useProperties from "~/v-admin-app/src/compose/useProperties.js"
export default {
  components: {},
  props: {
    forceShow: {
      type: Boolean,
      default: false,
    },
    currentModelForEditing: {
      type: Object,
      default() {
        return {}
      },
    },
    lastChangedField: {
      type: Object,
      default() {
        return {}
      },
    },
  },
  watch: {
    lastChangedField: {
      handler(to, from) {
        let changedFieldDetails = to.fieldDetails
        let fieldHasChanged = false
        let newValue = changedFieldDetails.newValue
        var originalValue =
          this.currentModelForEditing[changedFieldDetails.fieldName]
        fieldHasChanged = newValue !== originalValue
        let changedFieldName = changedFieldDetails.fieldName
        if (fieldHasChanged) {
          this.currPendingChanges[changedFieldName] = newValue
        } else {
          delete this.currPendingChanges[changedFieldName]
        }
      },
      deep: true,
      immediate: false,
    },
  },
  data() {
    return {
      currPendingChanges: {},
    }
  },
  computed: {
    hasPendingChanges() {
      return Object.keys(this.currPendingChanges).length > 0
    },
  },
  setup() {},
  methods: {
    runCancelListingChanges() {
      this.currPendingChanges = {}
      this.$emit("changesCanceled")
    },
    runModelUpdate() {
      this.$emit("runModelUpdate", this.currPendingChanges)
      this.currPendingChanges = {}
    },
  },
}
</script>
