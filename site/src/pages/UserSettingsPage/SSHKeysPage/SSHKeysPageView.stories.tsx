import { mockApiError } from "testHelpers/entities";
import { SSHKeysPageView } from "./SSHKeysPageView";
import type { Meta, StoryObj } from "@storybook/react";

const meta: Meta<typeof SSHKeysPageView> = {
  title: "pages/UserSettingsPage/SSHKeysPageView",
  component: SSHKeysPageView,
  args: {
    isLoading: false,
    sshKey: {
      user_id: "test-user-id",
      created_at: "2022-07-28T07:45:50.795918897Z",
      updated_at: "2022-07-28T07:45:50.795919142Z",
      public_key: "SSH-Key",
    },
  },
};

export default meta;
type Story = StoryObj<typeof SSHKeysPageView>;

export const Example: Story = {};

export const Loading: Story = {
  args: {
    isLoading: true,
  },
};

export const WithGetSSHKeyError: Story = {
  args: {
    sshKey: undefined,
    getSSHKeyError: mockApiError({
      message: "Failed to get SSH key",
    }),
  },
};

export const WithRegenerateSSHKeyError: Story = {
  args: {
    regenerateSSHKeyError: mockApiError({
      message: "Failed to regenerate SSH key",
    }),
  },
};
