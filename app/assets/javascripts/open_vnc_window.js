$(function() {
    $('#open_vnc_window_button').click(function() {
      // open window as a pop-up window
      new_window = window.open(vnc_path, 'vnc_window', 'height=800,width=1024');

      // open window as a new tab
      //new_window = window.open(vnc_path);

      if (window.focus) {
        new_window.focus()
      }
      return false;
    })
});      
