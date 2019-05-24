package model;

import jogamp.nativewindow.windows.MARGINS;
import org.apache.commons.math3.complex.Complex;
import org.jzy3d.analysis.AbstractAnalysis;
import org.jzy3d.chart.factories.AWTChartComponentFactory;
import org.jzy3d.colors.Color;
import org.jzy3d.colors.ColorMapper;
import org.jzy3d.colors.colormaps.ColorMapRainbow;
import org.jzy3d.maths.Range;
import org.jzy3d.plot3d.builder.Builder;
import org.jzy3d.plot3d.builder.Mapper;
import org.jzy3d.plot3d.builder.concrete.OrthonormalGrid;
import org.jzy3d.plot3d.primitives.Shape;
import org.jzy3d.plot3d.rendering.canvas.Quality;
import org.nd4j.linalg.factory.Nd4j;

import java.util.HashMap;

public class Quadratic extends AbstractAnalysis {
    private HashMap<String, Double> reader = new HashMap<>();

    public Quadratic(HashMap<String, Double> reader) throws Exception {
        this.reader = reader;

    }
    public Quadratic(){}
    @Override

    public void init() throws Exception {
        double[] u = Nd4j.linspace(0, 1, 60).toDoubleVector();
        double[] v = Nd4j.linspace(0, 1, 60).toDoubleVector();
        double k = reader.get("k");
        double[] e = new double[60];
        double[] g = new double[60];

        for (int i = 0; i < u.length; i++) {
            e[i] =9*Math.pow(reader.get("a3"), 2)*(2*Math.pow(u[i],2)*Math.pow(v[i],2)*Math.pow(k,2)+
                    Math.pow(v[i],4)*Math.pow(k,4)+2* Math.pow(v[i],2)*Math.pow(k,2)+1+2*Math.pow(u[i],2)+Math.pow(u[i],4));


            System.out.println(e[i]);
        }
        Mapper mapper = new Mapper() {
            @Override
            public double f(double x, double y) {
                return e[0];
            }
        };

        // Define range and precision for the function to plot
        Range range = new Range(-3, 3);
        int steps = 80;

        // Create the object to represent the function over the given range.
        final Shape surface = Builder.buildOrthonormal(new OrthonormalGrid(range, steps, range, steps), mapper);
        surface.setColorMapper(new ColorMapper(new ColorMapRainbow(), surface.getBounds().getZmin(), surface.getBounds().getZmax(), new Color(1, 1, 1, .5f)));
        surface.setFaceDisplayed(true);
        surface.setWireframeDisplayed(false);

        // Create a chart
        chart = AWTChartComponentFactory.chart(Quality.Advanced, getCanvasType());
        chart.getScene().getGraph().add(surface);
    }

    private double quasiconformalReplacementForU0(double u, double v, double k,
                                                  Complex r0, Complex r1, Complex r2, Complex r3) {
        return k * ((3 * (-1 * (r1.getReal() - r0.getReal()) + 2 * (r2.getReal() - r1.getReal()) - (r3.getReal() - r2.getReal())) * Math.pow(v, 2)) + 6 * ((r1.getImaginary() - r0.getImaginary()) - (r2.getImaginary() - r1.getImaginary())) * v + 3 * (r1.getReal() - r0.getImaginary()));
    }

    private double quasiconformalReplacementForU1(double u, double v, double k,
                                                  Complex r0, Complex r1, Complex r2, Complex r3) {
        return Math.pow(k, 2) * ((6 * (-1 * (r1.getImaginary() - r0.getImaginary()) + 2 * (r2.getImaginary() - r1.getImaginary()) - (r3.getImaginary() - r2.getImaginary())) * 2) + 6 * ((r1.getImaginary() - r0.getImaginary()) - (r2.getImaginary() - r1.getImaginary())) * v - 6 * ((r1.getReal() - r0.getReal()) - (r2.getReal() - r1.getReal())));
    }

    private double quasiconformalReplacementForU2(double u, double v, double k,
                                                  Complex r0, Complex r1, Complex r2, Complex r3) {
        return Math.pow(k, 3) * ((3 * ((r1.getReal() - r0.getReal()) - 2 * (r2.getReal() - r1.getReal()) + (r3.getReal() - r2.getReal()))));
    }

    private double quasiconformalReplacementForXV0(double u, double v, double k,
                                                   Complex r0, Complex r1, Complex r2, Complex r3) {
        return 3 * ((r1.getImaginary() - r0.getImaginary() - 2 * (r2.getImaginary() - r1.getImaginary()) + (r3.getImaginary() - r2.getImaginary())) * Math.pow(v, 2) + 6 * ((r1.getReal() - r0.getReal()) - (r2.getReal() - r1.getReal())) * v - 3 * (r1.getImaginary() - r0.getImaginary()));
    }

    private double quasiconformalReplacementForXV1(double u, double v, double k,
                                                   Complex r0, Complex r1, Complex r2, Complex r3) {
        return k * (6 * (-1 * (r1.getReal() - r0.getImaginary() + 2 * (r2.getReal() - r1.getReal()) - (r3.getReal() - r2.getReal())) * v + 6 * ((r1.getImaginary() - r0.getImaginary()) - (r2.getImaginary() - r1.getImaginary()))));
    }

    private double quasiconformalReplacementForXV2(double u, double v, double k,
                                                   Complex r0, Complex r1, Complex r2, Complex r3) {
        return Math.pow(k, 2) * ((3 * (-1 * (r1.getImaginary() - r0.getImaginary()) + 2 * (r2.getImaginary() - r1.getImaginary()) - (r3.getImaginary() - r2.getImaginary()))));
    }

    private void formula(double r0, double r1, double r2, double r, double u) {

        r = r0 + r1 * u + r2 * Math.pow(u, 2);

    }
}

