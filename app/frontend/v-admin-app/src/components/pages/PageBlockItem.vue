<template>
  <div>
    <div v-if="editorBlockItem.isHtml || editorBlockItem.isMultipleLineText">
      <HtmlField
        :cancelPendingChanges="cancelPendingChanges"
        :fieldDetails="editorBlockItemFieldDetails"
        :currentFieldValue="blockValue"
        v-on:updatePendingChanges="updatePendingChanges"
      ></HtmlField>
    </div>
    <div v-else-if="editorBlockItem.isSingleLineText">
      <TextField
        :cancelPendingChanges="cancelPendingChanges"
        :fieldDetails="editorBlockItemFieldDetails"
        :currentFieldValue="blockValue"
        v-on:updatePendingChanges="updatePendingChanges"
      ></TextField>
    </div>
    <div v-else-if="editorBlockItem.isImage">
      <ImageField
        :cancelPendingChanges="cancelPendingChanges"
        :fieldDetails="editorBlockItemFieldDetails"
        :currentFieldValue="blockValue"
        v-on:updatePendingChanges="updatePendingChanges"
      ></ImageField>
    </div>
    <div v-else>
      {{ blockValue }}
    </div>
  </div>
</template>
<script>
import ImageField from "~/v-admin-app/src/components/editor-forms-parts/ImageField.vue"
import TextField from "~/v-admin-app/src/components/editor-forms-parts/TextField.vue"
import HtmlField from "~/v-admin-app/src/components/editor-forms-parts/HtmlField.vue"
export default {
  components: {
    ImageField,
    TextField,
    HtmlField,
  },
  computed: {
    blockValue() {
      let localeBlockContents = this.pagePartDetails.block_contents[
        this.currentBlockLocale
      ] || { blocks: {} }
      let block = localeBlockContents.blocks[this.editorBlockItem.label] || {}
      return block.content || ""
    },
    editorBlockItemFieldDetails() {
      let qInputType = ""
      if (this.editorBlockItem.isMultipleLineText) {
        qInputType = "textarea"
      }
      if (this.editorBlockItem.isSingleLineText) {
        qInputType = "text"
      }
      return {
        qInputType: qInputType,
        fieldName: this.editorBlockItem.label,
        // "content", //
      }
    },
  },
  methods: {
    updatePendingChanges({ fieldDetails, newValue }) {
      this.$emit("updatePendingChanges", {
        fieldDetails: fieldDetails,
        newValue: newValue,
      })
    },
  },
  props: {
    cancelPendingChanges: {
      type: Boolean,
      default: false,
    },
    pagePartDetails: {},
    editorBlockItem: {},
    currentBlockLocale: {},
  },
  // setup(props) {},
  data() {
    return {}
  },
}
</script>
<style></style>
