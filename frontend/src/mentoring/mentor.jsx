import { useEffect, useState } from "react";
import Table from "react-bootstrap/Table";
import axios from "axios";
import { FaRegTrashCan } from "react-icons/fa6";
import { FaEdit } from "react-icons/fa";
import Stack from "react-bootstrap/Stack";
import Button from "react-bootstrap/Button";
import Container from "react-bootstrap/esm/Container";
import Modal from "react-bootstrap/Modal";
import Form from "react-bootstrap/Form";
import Toast from "react-bootstrap/Toast";
import ToastContainer from "react-bootstrap/ToastContainer";
import { useNavigate } from "react-router-dom";

export default function Mentor() {
	const [mentorList, setMentorList] = useState([]);
	const [showUpdate, setShowUpdate] = useState(false);
	const [numberUpdate, setNumberUpdate] = useState(0);
	const [salaryUpdate, setSalaryUpdate] = useState(0);
	const [showInsert, setShowInsert] = useState(false);
	const [show, setShow] = useState(false);
	const [errorMessage, setErrorMessage] = useState("");
	const navigate = useNavigate();
	const [selected, setSelected] = useState({});
	const handleCloseUpdate = () => {
		setSelected({});
		setShowUpdate(false);
		setNumberUpdate(0);
		setSalaryUpdate(0);
	};
	const handleShowUpdate = (mentorID, menteeID, courseID, sectionID) => {
		setShowUpdate(true);
		setSelected({ mentorID, menteeID, courseID, sectionID });
	};
	const handleCloseInsert = () => setShowInsert(false);
	const selectMentoring = async () => {
		const res = await axios.get("http://localhost:3000/mentors");
		setMentorList([...res.data]);
	};
	const onDelete = async (mentorID, menteeID, courseID, sectionID) => {
		try {
			const res = await axios.delete(
				`http://localhost:3000/mentors/${mentorID}/mentee/${menteeID}/course/${courseID}/section/${sectionID}`
			);
			navigate(0);
		} catch (error) {}
	};
	const onSaveUpdate = async () => {
		try {
			const res = await axios.put("http://localhost:3000/mentors", {
				...selected,
				number: numberUpdate,
				salary: salaryUpdate,
			});
			handleCloseUpdate();
			navigate(0);
		} catch (error) {}
	};
	const onInsert = async (e) => {
		e.preventDefault();
		const formData = new FormData(e.target),
			formDataObj = Object.fromEntries(formData.entries());
		const data = {
			mentorID: +formDataObj.mentorID,
			menteeID: +formDataObj.menteeID,
			courseID: formDataObj.courseID,
			sectionID: formDataObj.sectionID,
			number: +formDataObj.number,
			salary: +formDataObj.salary,
		};
		try {
			const res = await axios.post("http://localhost:3000/mentors", data);
			navigate(0);
		} catch (error) {
			handleCloseInsert();
			setErrorMessage(error.response.data.message);
			setShow(true);
		}
	};

	useEffect(() => {
		selectMentoring();
	}, []);
	return (
		<>
			<Stack gap={3}>
				<Container className="w-100 d-flex">
					<Button
						variant="outline-primary"
						className="ms-auto w-25"
						onClick={setShowInsert}
					>
						Add new mentoring
					</Button>
				</Container>
				<Table striped bordered hover responsive>
					<thead>
						<tr>
							<th>Mentor ID</th>
							<th>Mentor Name</th>
							<th>Mentor Email</th>
							<th>Mentee ID</th>
							<th>Mentee Name</th>
							<th>Mentee Email</th>
							<th>Course ID</th>
							<th>Section ID</th>
							<th>Salary</th>
							<th>Receive days</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						{mentorList.map((value, index) => (
							<>
								<tr key={`table-${index}`} id={index}>
									<td>{value.MentorID}</td>
									<td>{value.MentorFullName}</td>
									<td>{value.MentorEmail}</td>
									<td>{value.MenteeID}</td>
									<td>{value.MenteeFullName}</td>
									<td>{value.MenteeEmail}</td>
									<td>{value.CourseID}</td>
									<td>{value.SectionID}</td>
									<td>{value.Salary}</td>
									<td>{value.Number}</td>
									<td>
										<Stack direction="horizontal" gap={3}>
											<FaEdit
												onClick={() =>
													handleShowUpdate(
														value.MentorID,
														value.MenteeID,
														value.CourseID,
														value.SectionID
													)
												}
												style={{ cursor: "pointer" }}
											/>
											<FaRegTrashCan
												onClick={() =>
													onDelete(
														value.MentorID,
														value.MenteeID,
														value.CourseID,
														value.SectionID
													)
												}
												style={{ cursor: "pointer" }}
											/>
										</Stack>
									</td>
								</tr>
							</>
						))}
					</tbody>
				</Table>
				<Modal show={showUpdate} onHide={handleCloseUpdate}>
					<Modal.Header closeButton>
						<Modal.Title>Update</Modal.Title>
					</Modal.Header>
					<Modal.Body>
						<Form>
							<Form.Group
								className="mb-3"
								controlId="formBasicEmail"
							>
								<Form.Label>Received days</Form.Label>
								<Form.Control
									type="text"
									placeholder="Enter received days"
									value={numberUpdate}
									onChange={(e) =>
										setNumberUpdate(e.target.value)
									}
								/>
							</Form.Group>

							<Form.Group
								className="mb-3"
								controlId="formBasicPassword"
							>
								<Form.Label>Salary</Form.Label>
								<Form.Control
									type="text"
									placeholder="Enter salary"
									value={salaryUpdate}
									onChange={(e) =>
										setSalaryUpdate(e.target.value)
									}
								/>
							</Form.Group>
						</Form>
					</Modal.Body>
					<Modal.Footer>
						<Button variant="secondary" onClick={handleCloseUpdate}>
							Close
						</Button>
						<Button
							variant="primary"
							onClick={() => onSaveUpdate()}
						>
							Save Changes
						</Button>
					</Modal.Footer>
				</Modal>
				<Modal show={showInsert} onHide={handleCloseInsert}>
					<Modal.Header closeButton>
						<Modal.Title>Insert</Modal.Title>
					</Modal.Header>
					<Modal.Body>
						<Form id="insertForm" onSubmit={onInsert}>
							<Form.Group className="mb-3" controlId="number">
								<Form.Label>Received days</Form.Label>
								<Form.Control
									type="number"
									placeholder="Enter received days"
									name="number"
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="salary">
								<Form.Label>Salary</Form.Label>
								<Form.Control
									type="number"
									placeholder="Enter salary"
									name="salary"
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="mentorID">
								<Form.Label>Mentor ID</Form.Label>
								<Form.Control
									type="number"
									placeholder="Enter Mentor ID"
									name="mentorID"
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="menteeID">
								<Form.Label>Mentee ID</Form.Label>
								<Form.Control
									type="number"
									placeholder="Enter Mentee ID"
									name="menteeID"
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="courseID">
								<Form.Label>Course ID</Form.Label>
								<Form.Control
									type="text"
									placeholder="Enter Course ID"
									name="courseID"
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="sectionID">
								<Form.Label>Section ID</Form.Label>
								<Form.Control
									type="text"
									placeholder="Enter Section ID"
									name="sectionID"
								/>
							</Form.Group>
						</Form>
					</Modal.Body>
					<Modal.Footer>
						<Button variant="secondary" onClick={handleCloseUpdate}>
							Close
						</Button>
						<Button
							form="insertForm"
							type="submit"
							variant="primary"
						>
							Save Changes
						</Button>
					</Modal.Footer>
				</Modal>
				<ToastContainer
					position="top-center"
					className="p-3"
					style={{ zIndex: 1 }}
				>
					<Toast
						onClose={() => setShow(false)}
						show={show}
						delay={3000}
						autohide
						bg="danger"
					>
						<Toast.Body className="text-white">
							{errorMessage}
						</Toast.Body>
					</Toast>
				</ToastContainer>
			</Stack>
		</>
	);
}
