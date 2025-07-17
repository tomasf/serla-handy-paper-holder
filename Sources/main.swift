import Cadova

await Model("serla-handy-paper-holder") {
    Holder()
        .inPart(named: "holder")
    Lid()
        .translated(y: -110)
        .inPart(named: "lid")
}

struct Holder: Shape3D {
    let outerSize = Vector3D(219, 102, 155)
    let bottomHoleSize = Vector2D(187, 40)
    let wallThickness = 3.0
    let frontTopCornerRadius = 5.0
    let frontBottomCornerRadius = 10.0
    let frontOpeningWidth = 115.0
    let frontOpeningHeight = 136.0

    var body: any Geometry3D {
        let baseShape = Rectangle(outerSize.xy)
            .aligned(at: .center)
            .applyingEdgeProfile(.fillet(radius: wallThickness))

        baseShape
            .extruded(height: outerSize.z)
            .subtracting {
                baseShape.offset(amount: -wallThickness, style: .round)
                    .extruded(height: outerSize.z)
                    .translated(z: wallThickness)

                Box(Vector3D(bottomHoleSize, z: wallThickness))
                    .aligned(at: .centerXY)

                Rectangle(x: outerSize.x, y: outerSize.z)
                    .aligned(at: .centerX)
                    .adding {
                        Rectangle(x: frontOpeningWidth, y: frontOpeningHeight)
                            .aligned(at: .centerX, .maxY)
                    }
                    .rounded(insideRadius: frontTopCornerRadius, outsideRadius: frontBottomCornerRadius)
                    .extruded(height: wallThickness)
                    .rotated(x: 90°)
                    .aligned(at: .minY)
                    .translated(y: -outerSize.y / 2, z: outerSize.z)
            }
            .applyingEdgeProfile(.overhangFillet(radius: wallThickness), to: .bottom)
    }
}

struct Lid: Shape3D {
    let size = Vector3D(209, 90, 10.2)
    let holeSize = Vector2D(187, 40)
    let cornerRadius = 1.0

    var body: any Geometry3D {
        Rectangle(size.xy)
            .applyingEdgeProfile(.fillet(radius: cornerRadius))
            .aligned(at: .center)
            .subtracting {
                Rectangle(holeSize)
                    .aligned(at: .center)
            }
            .extruded(height: size.z)
    }
}
