import { Story } from "@storybook/react"
import React from "react"
import { AvatarData, AvatarDataProps } from "./AvatarData"

export default {
  title: "components/AvatarData",
  component: AvatarData,
}

const Template: Story<AvatarDataProps> = (args: AvatarDataProps) => <AvatarData {...args} />

export const Example = Template.bind({})
Example.args = {
  title: "coder",
  subtitle: "coder@coder.com",
}

export const WithLink = Template.bind({})
WithLink.args = {
  title: "coder",
  subtitle: "coder@coder.com",
  link: "/users/coder",
}
