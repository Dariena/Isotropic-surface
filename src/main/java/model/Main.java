package model;

import org.apache.commons.math3.complex.Complex;
import org.jzy3d.analysis.AbstractAnalysis;
import org.jzy3d.chart.factories.AWTChartComponentFactory;
import org.jzy3d.colors.Color;
import org.jzy3d.colors.ColorMapper;
import org.jzy3d.colors.colormaps.ColorMapRainbow;
import org.jzy3d.maths.Coord3d;
import org.jzy3d.plot3d.primitives.Point;
import org.jzy3d.plot3d.primitives.Polygon;
import org.jzy3d.plot3d.primitives.Shape;
import org.jzy3d.plot3d.rendering.canvas.Quality;
import org.nd4j.linalg.factory.Nd4j;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class Main extends AbstractAnalysis {
    private HashMap<String, Double> reader = new HashMap<>();

    public Main(HashMap<String, Double> reader) throws Exception {
        this.reader = reader;

    }

    @Override
    public void init() {
        double[] u = Nd4j.linspace(0, 1, 60).toDoubleVector();
        double[] v = Nd4j.linspace(0, 1, 60).toDoubleVector();
        double[] x = new double[60];
        double[] y = new double[60];
        double[] z = new double[60];
        Complex a0 = new Complex(reader.get("a0"), reader.get("a0im"));
        Complex a1 = new Complex(reader.get("a1"), reader.get("a1im"));
        Complex a2 = new Complex(reader.get("a2"), reader.get("a2im"));
        Complex a3 = new Complex(reader.get("a3"), reader.get("a3im"));

        Complex x0 = a0.subtract(a2);
        Complex x1 = a0.subtract(a2.add(a3));
        Complex x2 = a0.subtract(a2.add(a3.multiply(2)));
        Complex x3 = a0.subtract(a2.add(a3.multiply(2)));
        Complex y0 = a0.add(a2);
        Complex y1 = a0.add(a2).add(a3);
        Complex y2 = a0.add(a2).add(a3.multiply(2));
        Complex y3 = a0.add(a2).add(a3.multiply(4));
        Complex z0 = a1.multiply(-1);
        Complex z1 = a1.multiply(-1);
        Complex z2 = a3.subtract(a1);
        Complex z3 = a3.multiply(3).add(a1);


        for (int i = 0; i < u.length; i++) {
            x[i] = quasiconformalReplacement(u[i], v[i], reader.get("k"), x0, x1, x2, x3);
        }

        for (int i = 0; i < u.length; i++) {
            y[i] = quasiconformalReplacement(u[i], v[i], reader.get("k"), y0, y1, y2, y3);
        }

        for (int i = 0; i < u.length; i++) {
            z[i] = quasiconformalReplacement(u[i], v[i], reader.get("k"), z0, z1, z2, z3);
        }

        // Define range and precision for the function to plot
        double[][] distDataProp = new double[][]{x, y, z};
        List<Polygon> polygons = new ArrayList<Polygon>();
        for (int i = 0; i < distDataProp.length - 1; i++) {
            for (int j = 0; j < distDataProp[i].length - 1; j++) {
                Polygon polygon = new Polygon();
                polygon.add(new Point(new Coord3d(i, j, distDataProp[i][j])));
                polygon.add(new Point(new Coord3d(i, j + 1, distDataProp[i][j + 1])));
                polygon.add(new Point(new Coord3d(i + 1, j + 1, distDataProp[i + 1][j + 1])));
                polygon.add(new Point(new Coord3d(i + 1, j, distDataProp[i + 1][j])));
                polygons.add(polygon);
            }
        }

        // Create the object to represent the function over the given range.
        Shape surface = new Shape(polygons);
        surface.setColorMapper(new ColorMapper(new ColorMapRainbow(), surface.getBounds().getZmin(), surface.getBounds().getZmax(), new Color(1, 1, 1, .5f)));
        surface.setFaceDisplayed(true);
        surface.setWireframeDisplayed(true);

        // Create a chart
        chart = AWTChartComponentFactory.chart(Quality.Advanced, getCanvasType());
        chart.getScene().getGraph().add(surface);
    }

    private double quasiconformalReplacement(double u, double v, double k,
                                             Complex r0, Complex r1, Complex r2, Complex r3) {
        return r0.getReal() *
                (1 - 3 * u + 3 * Math.pow(u, 2) - 3 * Math.pow(v, 2) * Math.pow(k, 2) - Math.pow(u, 3) + 3 * u * Math.pow(v, 2) * Math.pow(k, 2)) -
                r0.getImaginary() * (-3 * v * k + 6 * u * v * k - 3 * Math.pow(u, 2) * v * k + Math.pow(v, 3) * Math.pow(k, 3)) - (-3 * r1.getReal() * (1 - 2 * u + Math.pow(u, 2) - Math.pow(v, 2) * Math.pow(k, 2)) + 3 * r1.getImaginary() * (-2 * v * k + 2 * u * k * v)) * u +
                (-3 * r1.getImaginary() * (1 - 2 * u - Math.pow(u, 2) - Math.pow(v, 2) * Math.pow(k, 2)) - 3 * r1.getReal() * (-2 * v * k + 2 * u * v * k)) * v * k -
                ((-3) * r2.getReal() * (1 - u) - 3 * r2.getImaginary() * v * k) * (Math.pow(u, 2) - Math.pow(v, 2) * Math.pow(k, 2)) + 2 * (-3 * r2.getImaginary() * (1 - u) + 3 * r2.getReal() * v * k) * u * v * k +
                r3.getReal() * (Math.pow(u, 3) - 3 * u * Math.pow(v, 2) * Math.pow(k, 2)) - r3.getImaginary() * (3 * Math.pow(u, 2) * v * k - Math.pow(v, 3) * Math.pow(k, 3));

    }


}
