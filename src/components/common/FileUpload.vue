&lt;template>
  <div class="space-y-4">
    <div
      class="flex justify-center px-6 pt-5 pb-6 border-2 border-gray-300 border-dashed rounded-md"
      :class="{ 'border-indigo-500': isDragging }"
      @drop.prevent="handleDrop"
      @dragover.prevent="isDragging = true"
      @dragleave.prevent="isDragging = false"
    >
      <div class="space-y-1 text-center">
        <svg
          class="mx-auto h-12 w-12 text-gray-400"
          stroke="currentColor"
          fill="none"
          viewBox="0 0 48 48"
          aria-hidden="true"
        >
          <path
            d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
        </svg>
        <div class="flex text-sm text-gray-600">
          <label
            :for="inputId"
            class="relative cursor-pointer bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus-within:outline-none focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-indigo-500"
          >
            <span>Upload a file</span>
            <input
              :id="inputId"
              :name="name"
              type="file"
              class="sr-only"
              :accept="accept"
              @change="handleFileSelect"
              :multiple="multiple"
            />
          </label>
          <p class="pl-1">or drag and drop</p>
        </div>
        <p class="text-xs text-gray-500">
          {{ acceptedFileTypes }} up to {{ maxSizeMB }}MB
        </p>
      </div>
    </div>

    <!-- Preview -->
    <div v-if="preview" class="mt-4">
      <div v-if="isImage" class="relative">
        <img
          :src="preview"
          class="max-h-48 rounded-lg"
          :alt="selectedFile?.name"
        />
        <button
          @click="clearFile"
          class="absolute top-2 right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600"
        >
          <svg
            class="h-4 w-4"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>
      </div>
      <div v-else class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
        <div class="flex items-center">
          <svg
            class="h-8 w-8 text-gray-400"
            fill="currentColor"
            viewBox="0 0 20 20"
          >
            <path
              fill-rule="evenodd"
              d="M4 4a2 2 0 012-2h8a2 2 0 012 2v12a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 0v12h8V4H6z"
              clip-rule="evenodd"
            />
          </svg>
          <span class="ml-2 text-sm text-gray-900">{{ selectedFile?.name }}</span>
        </div>
        <button
          @click="clearFile"
          class="text-red-500 hover:text-red-700"
        >
          Remove
        </button>
      </div>
    </div>

    <!-- Error Message -->
    <p v-if="error" class="mt-2 text-sm text-red-600">
      {{ error }}
    </p>

    <!-- Upload Progress -->
    <div v-if="uploading" class="relative pt-1">
      <div class="flex mb-2 items-center justify-between">
        <div>
          <span class="text-xs font-semibold inline-block py-1 px-2 uppercase rounded-full text-indigo-600 bg-indigo-200">
            Uploading
          </span>
        </div>
        <div class="text-right">
          <span class="text-xs font-semibold inline-block text-indigo-600">
            {{ uploadProgress }}%
          </span>
        </div>
      </div>
      <div class="overflow-hidden h-2 mb-4 text-xs flex rounded bg-indigo-200">
        <div
          :style="{ width: uploadProgress + '%' }"
          class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-indigo-500"
        ></div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import axios from 'axios';

const props = defineProps({
  name: {
    type: String,
    required: true,
  },
  accept: {
    type: String,
    default: 'image/*',
  },
  maxSizeMB: {
    type: Number,
    default: 5,
  },
  multiple: {
    type: Boolean,
    default: false,
  },
  endpoint: {
    type: String,
    required: true,
  },
});

const emit = defineEmits(['upload-success', 'upload-error', 'file-removed']);

const inputId = computed(() => `file-upload-${props.name}`);
const acceptedFileTypes = computed(() => {
  if (props.accept === 'image/*') return 'PNG, JPG, GIF';
  if (props.accept === 'application/pdf') return 'PDF';
  return props.accept.split(',').join(', ');
});

const isDragging = ref(false);
const selectedFile = ref(null);
const preview = ref(null);
const error = ref(null);
const uploading = ref(false);
const uploadProgress = ref(0);

const isImage = computed(() => 
  selectedFile.value?.type.startsWith('image/')
);

const validateFile = (file) => {
  if (file.size > props.maxSizeMB * 1024 * 1024) {
    throw new Error(`File size must be less than ${props.maxSizeMB}MB`);
  }

  const acceptedTypes = props.accept.split(',').map(type => type.trim());
  if (!acceptedTypes.some(type => {
    if (type.includes('/*')) {
      return file.type.startsWith(type.replace('/*', ''));
    }
    return file.type === type;
  })) {
    throw new Error('File type not accepted');
  }
};

const createPreview = (file) => {
  if (file.type.startsWith('image/')) {
    const reader = new FileReader();
    reader.onload = (e) => {
      preview.value = e.target.result;
    };
    reader.readAsDataURL(file);
  } else {
    preview.value = 'document';
  }
};

const handleFileSelect = (event) => {
  const file = event.target.files[0];
  if (!file) return;

  try {
    validateFile(file);
    selectedFile.value = file;
    createPreview(file);
    error.value = null;
    uploadFile(file);
  } catch (err) {
    error.value = err.message;
    emit('upload-error', err.message);
  }
};

const handleDrop = (event) => {
  isDragging.value = false;
  const file = event.dataTransfer.files[0];
  if (!file) return;

  try {
    validateFile(file);
    selectedFile.value = file;
    createPreview(file);
    error.value = null;
    uploadFile(file);
  } catch (err) {
    error.value = err.message;
    emit('upload-error', err.message);
  }
};

const uploadFile = async (file) => {
  const formData = new FormData();
  formData.append(props.name, file);

  try {
    uploading.value = true;
    const response = await axios.post(props.endpoint, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      onUploadProgress: (progressEvent) => {
        uploadProgress.value = Math.round(
          (progressEvent.loaded * 100) / progressEvent.total
        );
      },
    });
    emit('upload-success', response.data);
  } catch (err) {
    error.value = 'Upload failed. Please try again.';
    emit('upload-error', err);
  } finally {
    uploading.value = false;
    uploadProgress.value = 0;
  }
};

const clearFile = () => {
  selectedFile.value = null;
  preview.value = null;
  error.value = null;
  emit('file-removed');
};
</script>
