fn ok [f]{
  try $f
  except; false
  tried
}

fn not-ok [f]{
  try $f; false
  except
  tried
}
