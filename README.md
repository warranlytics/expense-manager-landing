# Expenser - Landing Page

A modern, responsive landing page for the Expenser platform built with Next.js 15 and Tailwind CSS. This is a static site (SSG) showcasing the features and benefits of the Expenser application.

## ✨ Features

- 🎨 **Modern Design** - Clean, professional design with gradient backgrounds and smooth animations
- 📱 **Fully Responsive** - Optimized for all screen sizes (mobile, tablet, desktop)
- ⚡ **Static Site Generation (SSG)** - Pre-rendered at build time for optimal performance
- 🎯 **SEO Optimized** - Proper meta tags, Open Graph tags, and semantic HTML
- 🚀 **Lightning Fast** - Built with Next.js 15 and Turbopack
- 🎭 **Smooth Animations** - Hover effects and transitions for better UX
- ♿ **Accessible** - Semantic HTML and ARIA labels where needed

## 🛠️ Tech Stack

- **Next.js 15** - React framework with App Router
- **React 18** - UI library
- **Tailwind CSS** - Utility-first CSS framework
- **TypeScript** - Type-safe JavaScript (via JSConfig)

## 🚀 Getting Started

### Prerequisites

- Node.js 20+
- pnpm (recommended) or npm

### Installation

1. Install dependencies:

```bash
pnpm install
```

### Development

Run the development server:

```bash
pnpm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the landing page.

### Build

Build the static site for production:

```bash
pnpm run build
```

This generates a static export in the `out/` directory.

### Preview

Preview the production build locally:

```bash
npx serve@latest out
```

## 📁 Project Structure

```
expense-manager-landing/
├── src/
│   └── app/
│       ├── favicon.ico        # Favicon
│       ├── globals.css        # Global styles
│       ├── layout.js          # Root layout with metadata
│       └── page.js            # Landing page (main content)
├── public/                    # Static assets
├── next.config.mjs           # Next.js configuration (SSG enabled)
├── tailwind.config.js        # Tailwind CSS configuration
├── package.json              # Dependencies and scripts
└── README.md                 # This file
```

## 📄 Page Sections

1. **Hero Section** - Headline, CTA, and key statistics
2. **Features Section** - 6 key features with icons
3. **How It Works** - 3-step process explanation
4. **Tech Stack** - Technologies showcase
5. **CTA Section** - Sign-up encouragement
6. **Footer** - Quick links and information

## ⚙️ Configuration

### Static Site Generation

Configured in `next.config.mjs`:

```javascript
const nextConfig = {
	output: 'export', // Enable static export
	images: {
		unoptimized: true,
	},
};
```

### SEO Metadata

Configured in `src/app/layout.js`:

```javascript
export const metadata = {
	title: 'Expenser - Take Control of Your Personal Finances',
	description: 'Track expenses, analyze spending patterns...',
	keywords: ['expense tracker', 'finance management', 'budgeting'],
};
```

## 🎨 Customization

### Content

Edit `src/app/page.js` to modify landing page content.

### Styling

- **Colors**: Update `tailwind.config.js`
- **Fonts**: Modify font imports in `src/app/layout.js`
- **Global styles**: Edit `src/app/globals.css`

## 🚀 Deployment

### Vercel (Recommended)

```bash
vercel
```

### Netlify

```bash
pnpm run build
netlify deploy --prod --dir=out
```

### Docker + Nginx

```dockerfile
FROM nginx:alpine
COPY out/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

```bash
docker build -t expense-manager-landing .
docker run -p 80:80 expense-manager-landing
```

## 🔗 Related Projects

- **expense-manager-apis** - Backend REST API
- **expense-manager-app** - Frontend web application
- **expense-manager-loadbalancer** - Nginx load balancer

## 📝 License

Part of the Expenser platform.
