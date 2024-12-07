import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";
import { Outlet } from "react-router-dom";

export default function Root() {
	return (
		<>
			<Navbar bg="dark" data-bs-theme="dark">
				<Container>
					<Navbar.Brand href="/">University Management</Navbar.Brand>
					<Nav className="me-auto">
						<Nav.Link href="/">Mentoring</Nav.Link>
						<Nav.Link href="/">Person</Nav.Link>
					</Nav>
				</Container>
			</Navbar>
			<Container className="mt-5">
				<Outlet />
			</Container>
		</>
	);
}
