/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

// MARK: This is how we configure the side menu

protocol MenuDelegate: class {
  func didSelectMenuItem(_ item: MenuItem)
}

class MenuViewController: UITableViewController {
  
  weak var delegate: MenuDelegate?
  
  // MARK: Set the max cell height
  let maxCellHeight: CGFloat = 100
  
  // MARK: Get a reference to our datasource
  private var datasource: MenuDataSource = MenuDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = datasource
  }
  
  // MARK: Do something when we seque from the detail view controller (removed so we didn't have such a tight bind to detail view controller)
  /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   if let destination = segue.destination as? DetailViewController,
   let indexPath = tableView.indexPathForSelectedRow {
   let item = datasource.menuItems[indexPath.row]
   destination.menuItem = item
   }
   }*/
  
  // MARK: Setting the height for the rows
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let proposedHeight = tableView.safeAreaLayoutGuide.layoutFrame.height/CGFloat(datasource.menuItems.count)
    return min(maxCellHeight, proposedHeight)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    let item = datasource.menuItems[indexPath.row]
    delegate?.didSelectMenuItem(item)
    
    DispatchQueue.main.async {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
}
