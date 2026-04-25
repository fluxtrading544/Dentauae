import { defineRouteConfig } from "@medusajs/admin-sdk";
import { Container, Heading, Table, Text, Badge } from "@medusajs/ui";
import { useState, useEffect } from "react";
import { DocumentText } from "@medusajs/icons";

interface AdminOrder {
    id: string;
    display_id: string;
    email: string;
    status: string;
    total: number;
    shipping_address?: {
        first_name: string;
        last_name: string;
        phone: string;
    };
}

const OrderRecordsPage = () => {
    const [orders, setOrders] = useState<AdminOrder[]>([]);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const fetchOrders = async () => {
            try {
                // Fetch orders from the Medusa Admin API directly
                const response = await fetch("/admin/orders", {
                    headers: {
                        "Content-Type": "application/json"
                    }
                });
                const data = await response.json();
                setOrders(data.orders || []);
            } catch {
                console.error("Failed to load records");
            } finally {
                setIsLoading(false);
            }
        };
        fetchOrders();
    }, []);

    return (
        <Container className="flex flex-col gap-6 p-8">
            <div className="flex items-center gap-4">
                <div className="bg-primary/10 p-3 rounded-2xl text-primary font-bold">
                    <DocumentText />
                </div>
                <div>
                    <Heading level="h1">Customer Order Records</Heading>
                    <Text className="text-ui-fg-subtle">A consolidated view of all customer contact data per order.</Text>
                </div>
            </div>

            <Table>
                <Table.Header>
                    <Table.Row>
                        <Table.HeaderCell>Order ID</Table.HeaderCell>
                        <Table.HeaderCell>Customer Name</Table.HeaderCell>
                        <Table.HeaderCell>Email Address</Table.HeaderCell>
                        <Table.HeaderCell>Phone Number</Table.HeaderCell>
                        <Table.HeaderCell>Status</Table.HeaderCell>
                        <Table.HeaderCell>Total</Table.HeaderCell>
                    </Table.Row>
                </Table.Header>
                <Table.Body>
                    {orders.length > 0 ? orders.map((order) => (
                        <Table.Row key={order.id}>
                            <Table.Cell className="font-mono text-xs font-bold text-primary">
                                DENTA-{order.display_id}
                            </Table.Cell>
                            <Table.Cell>
                                {order.shipping_address?.first_name} {order.shipping_address?.last_name}
                            </Table.Cell>
                            <Table.Cell>{order.email}</Table.Cell>
                            <Table.Cell>{order.shipping_address?.phone || "Not Provided"}</Table.Cell>
                            <Table.Cell>
                                <Badge color={order.status === "completed" ? "green" : "orange"}>
                                    {(order.status || "PENDING").toUpperCase()}
                                </Badge>
                            </Table.Cell>
                            <Table.Cell className="font-bold">
                                {new Intl.NumberFormat('en-AE', { style: 'currency', currency: 'AED' }).format(order.total / 100)}
                            </Table.Cell>
                        </Table.Row>
                    )) : !isLoading && (
                        <Table.Row>
                            {/* Standard td used instead of Table.Cell to support colSpan without type errors */}
                            <td colSpan={6} className="text-center py-10 text-ui-fg-subtle text-sm">
                                No records found.
                            </td>
                        </Table.Row>
                    )}
                </Table.Body>
            </Table>
        </Container>
    );
};

export const config = defineRouteConfig({
    label: "Customer Records",
    icon: DocumentText,
});

export default OrderRecordsPage;
