import './App.css'
import {
  createBrowserRouter,
  RouterProvider,
  Route,
  Link,
} from "react-router-dom";
import Root from './root/root';
import Mentor from './mentoring/mentor';
const router = createBrowserRouter([
  {
    path: "/",
    element: <Root/>,
    children: [
      { index: true, element: <Mentor /> },
    ]
  },
]);
function App() {

  return (
    <>
      <RouterProvider router={router} />
    </>
  )
}

export default App
