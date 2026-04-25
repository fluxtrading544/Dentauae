import { MessageSquare, Mail, Phone } from "lucide-react";

export const ContactGrid = () => {
  const methods = [
    {
      icon: <MessageSquare className="text-primary" size={32} />,
      title: "Chat with us now",
      details: "Mon–Sat 9am–9pm UAE time.",
      footer: "Instant support for quick questions.",
    },
    {
      icon: <Mail className="text-primary" size={32} />,
      title: "support@dentauae.com",
      details: "Response within 4 hours.",
      footer: "Best for order and clinical documentation.",
    },
    {
      icon: <Phone className="text-primary" size={32} />,
      title: "+971 4 XXX XXXX",
      details: "Sun–Thu 9am–6pm.",
      footer: "Direct line to our Dubai-based support center.",
    },
  ];

  return (
    <section className="max-w-7xl mx-auto px-8 py-16">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        {methods.map((method, i) => (
          <div key={i} className="bg-white p-10 rounded-3xl border border-gray-100 flex flex-col gap-6 hover:shadow-xl transition-all duration-300">
            <div className="w-16 h-16 bg-[#F0F7F5] rounded-2xl flex items-center justify-center">
              {method.icon}
            </div>
            <div className="flex flex-col gap-2">
              <h3 className="text-2xl font-serif font-bold text-primary-dark">{method.title}</h3>
              <p className="text-gray-600 font-medium">{method.details}</p>
            </div>
            <p className="text-xs text-gray-400 uppercase tracking-widest font-bold mt-auto">
              {method.footer}
            </p>
          </div>
        ))}
      </div>
    </section>
  );
};
