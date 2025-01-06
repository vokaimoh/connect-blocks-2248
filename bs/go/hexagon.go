components {
  id: "hexagon"
  component: "/bs/scripts/hexagon.script"
}
embedded_components {
  id: "sprite-visual"
  type: "sprite"
  data: "default_animation: \"hexagon-main\"\n"
  "material: \"/bs/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/bs/atlases/main.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.2
  }
}
embedded_components {
  id: "sprite-shadow"
  type: "sprite"
  data: "default_animation: \"hexagon-shadow\"\n"
  "material: \"/bs/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/bs/atlases/main.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.1
  }
}
embedded_components {
  id: "label"
  type: "label"
  data: "size {\n"
  "  x: 64.0\n"
  "  y: 32.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"2\"\n"
  "font: \"/bs/fonts/liberation-sans-36.font\"\n"
  "material: \"/builtins/fonts/label.material\"\n"
  ""
  position {
    z: 0.3
  }
}
