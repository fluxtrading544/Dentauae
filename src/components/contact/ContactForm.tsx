"use client";

import { useState } from "react";
import { sendContactMessage } from "@/lib/data/contact";
import { CheckCircle2, Loader2 } from "lucide-react";

export const ContactForm = () => {
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    subject: "General Inquiry",
    message: ""
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await sendContactMessage(formData);
      setSuccess(true);
      setFormData({ name: "", email: "", subject: "General Inquiry", message: "" });
    } catch {
      alert("Failed to send message. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    return (
      <div className="bg-[#F0F7F5] p-12 rounded-[3rem] text-center flex flex-col items-center gap-6 animate-in fade-in zoom-in duration-500">
        <div className="w-20 h-20 bg-primary text-white rounded-full flex items-center justify-center shadow-lg">
          <CheckCircle2 size={40} />
        </div>
        <h2 className="text-3xl font-serif font-bold text-primary-dark">Message Sent Successfully</h2>
        <p className="text-gray-600 max-w-md mx-auto">
          Thank you for reaching out to DentaUAE. Our clinical concierge team will review your request and get back to you within 2-4 hours.
        </p>
        <button 
          onClick={() => setSuccess(false)}
          className="mt-4 text-primary font-bold hover:underline"
        >
          Send another message
        </button>
      </div>
    );
  }

  return (
    <div className="bg-white p-10 lg:p-16 rounded-[3rem] border border-gray-100 shadow-sm">
      <div className="flex flex-col gap-10">
        <div className="flex flex-col gap-2">
          <h2 className="text-3xl font-serif font-bold text-primary-dark">Send us a Message</h2>
          <p className="text-gray-500">Required fields are marked with an asterisk (*)</p>
        </div>

        <form onSubmit={handleSubmit} className="flex flex-col gap-8">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div className="flex flex-col gap-2">
              <label className="text-sm font-bold text-gray-700 tracking-wide uppercase">Your Name *</label>
              <input 
                required
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
                type="text" 
                placeholder="Dr. Sarah Salem" 
                className="w-full bg-[#F9F9F7] border-transparent focus:bg-white focus:ring-2 focus:ring-primary/20 focus:border-primary px-6 py-4 rounded-xl transition-all outline-none"
              />
            </div>
            <div className="flex flex-col gap-2">
              <label className="text-sm font-bold text-gray-700 tracking-wide uppercase">Email Address *</label>
              <input 
                required
                value={formData.email}
                onChange={(e) => setFormData({...formData, email: e.target.value})}
                type="email" 
                placeholder="sarah@clinic.ae" 
                className="w-full bg-[#F9F9F7] border-transparent focus:bg-white focus:ring-2 focus:ring-primary/20 focus:border-primary px-6 py-4 rounded-xl transition-all outline-none"
              />
            </div>
          </div>

          <div className="flex flex-col gap-2">
            <label className="text-sm font-bold text-gray-700 tracking-wide uppercase">Subject</label>
            <select 
              value={formData.subject}
              onChange={(e) => setFormData({...formData, subject: e.target.value})}
              className="w-full bg-[#F9F9F7] border-transparent focus:bg-white focus:ring-2 focus:ring-primary/20 focus:border-primary px-6 py-4 rounded-xl transition-all outline-none appearance-none"
            >
              <option>General Inquiry</option>
              <option>Clinical Logistics</option>
              <option>Wholesale Order</option>
              <option>Technical Support</option>
            </select>
          </div>

          <div className="flex flex-col gap-2">
            <label className="text-sm font-bold text-gray-700 tracking-wide uppercase">Your Message *</label>
            <textarea 
              required
              value={formData.message}
              onChange={(e) => setFormData({...formData, message: e.target.value})}
              rows={5}
              placeholder="How can our clinical team assist you today?"
              className="w-full bg-[#F9F9F7] border-transparent focus:bg-white focus:ring-2 focus:ring-primary/20 focus:border-primary px-6 py-4 rounded-xl transition-all outline-none resize-none"
            />
          </div>

          <button 
            disabled={loading}
            className="w-full lg:w-fit bg-primary hover:bg-primary-dark disabled:bg-gray-300 text-white px-12 py-5 rounded-2xl font-bold tracking-widest shadow-lg shadow-primary/20 transition-all flex items-center justify-center gap-3"
          >
            {loading ? <Loader2 className="animate-spin" size={20} /> : null}
            {loading ? "SENDING..." : "DISPATCH MESSAGE"}
          </button>
        </form>
      </div>
    </div>
  );
};
